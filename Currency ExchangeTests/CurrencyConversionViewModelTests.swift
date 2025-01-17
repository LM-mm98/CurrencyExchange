//
//  CurrencyConversionViewModelTests.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//

import XCTest
@testable import Currency_Exchange

class CurrencyConversionViewModelTests: XCTestCase {
    private var viewModel: CurrencyConversionViewModel!
    private var mockHistoryStorage: MockHistoryStorage!

    override func setUp() {
        super.setUp()
        mockHistoryStorage = MockHistoryStorage()
        viewModel = CurrencyConversionViewModel(
            sourceCurrency: Currency(id: "USD", flag: "🇺🇸", exchangeRate: 1.0),
            destinationCurrency: Currency(id: "EUR", flag: "🇪🇺", exchangeRate: 0.9),
            historyStorage: mockHistoryStorage
        )
    }

    func testValidateSourceInputWithValidAmount() {
        viewModel.sourceAmount = "20"
        XCTAssertTrue(viewModel.validateSourceInput())
        XCTAssertNil(viewModel.sourceErrorMessage)
    }

    func testValidateSourceInputWithInvalidAmount() {
        viewModel.sourceAmount = "5"
        XCTAssertFalse(viewModel.validateSourceInput())
        XCTAssertEqual(viewModel.sourceErrorMessage, Constants.ErrorMessages.valueTooLow)
    }

    func testUpdateDestinationAmount() {
        viewModel.sourceAmount = "100"
        viewModel.updateDestinationAmount()
        XCTAssertEqual(viewModel.destinationAmount, "90")
    }

    func testUpdateSourceAmount() {
        viewModel.destinationAmount = "90"
        viewModel.updateSourceAmount()
        XCTAssertEqual(viewModel.sourceAmount, "100")
    }

    func testSaveToHistory() {
        viewModel.sourceAmount = "100"
        viewModel.destinationAmount = "90"
        viewModel.saveToHistory()
        
        XCTAssertEqual(mockHistoryStorage.savedHistory.count, 1)
        XCTAssertEqual(mockHistoryStorage.savedHistory.first?.sourceAmount, "100")
    }

    func testHistoryDoesNotExceedMaximumCount() {
        for i in 1...12 {
            let historyEntry = ConversionHistory(sourceAmount: "\(i)", sourceCurrency: "USD", destinationCurrency: "EUR", destinationAmount: "\(Double(i) * 0.9)", exchangeRate: 0.9, sourceCurrencyFlag: "🇺🇸", destinationCurrencyFlag: "🇪🇺")
            viewModel.addToHistory(historyEntry)
        }
        XCTAssertEqual(viewModel.history.count, 10)
    }
}

class MockHistoryStorage: HistoryStorage {
    var savedHistory: [ConversionHistory] = []

    func save(history: [ConversionHistory]) {
        savedHistory = history
    }

    func load() -> [ConversionHistory] {
        return savedHistory
    }
}
