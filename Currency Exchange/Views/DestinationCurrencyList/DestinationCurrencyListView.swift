//
//  DestinationCurrencyListView.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/13/25.
//

import SwiftUI

struct DestinationCurrencyListView: View {
    @StateObject private var viewModel: DestinationCurrencyViewModel
    @State private var showErrorSheet: Bool = false
    
    init(sourceCurrency: Currency, service: CurrencyServiceProtocol, sourceCurrencies: [Currency]) {
        _viewModel = StateObject(
            wrappedValue: DestinationCurrencyViewModel(
                service: service,
                sourceCurrency: sourceCurrency,
                sourceCurrencies: sourceCurrencies
            )
        )
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView(Constants.DestinationCurrencyListView.loadingMessage)
            } else {
                DestinationCurrencyList(
                    currencies: viewModel.destinationCurrencies,
                    navigationDestination: { currency in
                        CurrencyConversionView(
                            sourceCurrency: viewModel.sourceCurrency,
                            destinationCurrency: currency
                        )
                    }
                )
            }
        }
        .navigationTitle(Constants.DestinationCurrencyListView.navigationTitle)
        .onAppear {
            viewModel.fetchExchangeRates()
        }
        .errorSheet(isPresented: $showErrorSheet, errorMessage: viewModel.errorMessage) {
            showErrorSheet = false
        }
        .onChange(of: viewModel.hasError) { _, newValue in
            showErrorSheet = newValue
        }
    }
}




