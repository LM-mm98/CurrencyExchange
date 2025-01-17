//
//  CurrencyListViewTests.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//


import XCTest
import SwiftUI
@testable import Currency_Exchange
import Combine

class MockCurrencyService: CurrencyServiceProtocol {
    var mockResponse: Result<ExchangeRateResponse, Error>?
    
    func fetchExchangeRates(base: String) -> AnyPublisher<ExchangeRateResponse, Error> {
        guard let response = mockResponse else {
            return Fail(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock response"])).eraseToAnyPublisher()
        }
        
        return Future { promise in
            promise(response)
        }
        .eraseToAnyPublisher()
    }
    
    func fetchCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        completion(.success([
            Currency(id: "USD", name: "US Dollar", flag: "🇺🇸", exchangeRate: 1.0),
            Currency(id: "EUR", name: "Euro", flag: "🇪🇺", exchangeRate: 0.9)
        ]))
    }
}


class CurrencyViewModelTests: XCTestCase {
    func testInitializationWithCurrencies() {
        let currencies = [
            Currency(id: "USD", name: "US Dollar", flag: "🇺🇸", exchangeRate: 1.0),
            Currency(id: "EUR", name: "Euro", flag: "🇪🇺", exchangeRate: 0.9)
        ]
        let viewModel = CurrencyViewModel(sourceCurrencies: currencies)
        XCTAssertEqual(viewModel.sourceCurrencies.count, currencies.count)
        XCTAssertEqual(viewModel.sourceCurrencies.first?.id, "USD")
    }
}
