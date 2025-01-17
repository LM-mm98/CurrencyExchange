//
//  CurrencyService.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/13/25.
//

import Foundation
import Combine

protocol CurrencyServiceProtocol {
    func fetchExchangeRates(base: String) -> AnyPublisher<ExchangeRateResponse, Error>
}

class CurrencyService: CurrencyServiceProtocol {
    private let baseURL = Constants.ExchangeRateAPIBaseURL
    
    func fetchExchangeRates(base: String) -> AnyPublisher<ExchangeRateResponse, Error> {
        guard let url = URL(string: "\(baseURL)\(base)") else {
            print("[CurrencyService] Error: Invalid URL: \(baseURL)\(base)")
            return Fail(error: CurrencyServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        print("[CurrencyService] Requesting exchange rates for base: \(base)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw CurrencyServiceError.invalidResponse
                }
                return output.data
            }
            .decode(type: ExchangeRateResponse.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return CurrencyServiceError.decodingError
                } else {
                    return CurrencyServiceError.networkError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
