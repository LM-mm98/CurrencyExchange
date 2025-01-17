//
//  DestinationCurrencyViewModelTests.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//


import XCTest
import Combine
@testable import Currency_Exchange

class DestinationCurrencyViewModelTests: XCTestCase {
    var viewModel: DestinationCurrencyViewModel!
    var mockService: MockCurrencyService!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockService = MockCurrencyService()
        let sourceCurrency = Currency(id: "USD", name: "US Dollar", flag: "🇺🇸", exchangeRate: 1.0)
        let sourceCurrencies = [
            sourceCurrency,
            Currency(id: "EUR", name: "Euro", flag: "🇪🇺", exchangeRate: 0.9),
            Currency(id: "JPY", name: "Japanese Yen", flag: "🇯🇵", exchangeRate: 110.0)
        ]
        viewModel = DestinationCurrencyViewModel(service: mockService, sourceCurrency: sourceCurrency, sourceCurrencies: sourceCurrencies)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchExchangeRates_Success() {
        // Arrange
        let expectation = XCTestExpectation(description: "Exchange rates fetched successfully")
        mockService.mockResponse = .success(ExchangeRateResponse(base: "USD", rates: ["EUR": 0.9, "JPY": 110.0]))

        // Act
        viewModel.fetchExchangeRates()

        // Assert
        viewModel.$destinationCurrencies
            .dropFirst()
            .sink { currencies in
                XCTAssertEqual(currencies.count, 2)
                XCTAssertEqual(currencies.first?.id, "EUR")
                XCTAssertEqual(currencies.first?.exchangeRate, 0.9)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchExchangeRates_Failure() {
        // Arrange
        let expectation = XCTestExpectation(description: "Error state is updated on failure")
        mockService.mockResponse = .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"]))

        // Act
        viewModel.fetchExchangeRates()

        // Assert
        viewModel.$hasError
            .dropFirst()
            .sink { hasError in
                XCTAssertTrue(hasError)
                XCTAssertEqual(self.viewModel.errorMessage?.message, "Mock error")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchExchangeRates_InvalidSourceCurrencyId() {
        // Arrange
        viewModel = DestinationCurrencyViewModel(service: mockService, sourceCurrency: Currency(id: nil, name: "Invalid", flag: "🏳️", exchangeRate: nil), sourceCurrencies: [])

        // Act
        viewModel.fetchExchangeRates()

        // Assert
        XCTAssertTrue(viewModel.hasError)
        XCTAssertEqual(viewModel.errorMessage?.message, Constants.ErrorMessages.invalidId)
    }

    func testFetchExchangeRates_ExcludesSourceCurrency() {
        // Arrange
        let expectation = XCTestExpectation(description: "Source currency is excluded from results")
        mockService.mockResponse = .success(ExchangeRateResponse(base: "USD", rates: ["EUR": 0.9, "JPY": 110.0]))

        // Act
        viewModel.fetchExchangeRates()

        // Assert
        viewModel.$destinationCurrencies
            .dropFirst()
            .sink { currencies in
                XCTAssertFalse(currencies.contains(where: { $0.id == "USD" }))
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }
}
