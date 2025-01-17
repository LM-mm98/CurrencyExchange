//
//  DestinationCurrencyViewModel.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/13/25.
//

import Combine
import Foundation

class DestinationCurrencyViewModel: ObservableObject {
    @Published var destinationCurrencies: [Currency] = []
    @Published var errorMessage: IdentifiableError?
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let service: CurrencyServiceProtocol
    let sourceCurrency: Currency
    private let sourceCurrencies: [Currency]
    
    init(service: CurrencyServiceProtocol, sourceCurrency: Currency, sourceCurrencies: [Currency]) {
        self.service = service
        self.sourceCurrency = sourceCurrency
        self.sourceCurrencies = sourceCurrencies
    }
    
    func fetchExchangeRates() {
        guard let sourceCurrencyId = sourceCurrency.id else {
            errorMessage = IdentifiableError(message: Constants.ErrorMessages.invalidId)
            hasError = true
            return
        }
        
        isLoading = true
        service.fetchExchangeRates(base: sourceCurrencyId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: processExchangeRates)
            .store(in: &cancellables)
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        isLoading = false
        if case .failure(let error) = completion {
            errorMessage = IdentifiableError(message: error.localizedDescription)
            hasError = true
        }
    }
    
    private func processExchangeRates(_ response: ExchangeRateResponse) {
        destinationCurrencies = sourceCurrencies.compactMap { currency in
            guard let id = currency.id, id != sourceCurrency.id,
                  let rate = response.rates?[id] else { return nil }
            return Currency(
                id: id,
                name: currency.name ?? Constants.Unknown,
                flag: currency.flag ?? "🏳️",
                exchangeRate: rate
            )
        }
    }
}
