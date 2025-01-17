//
//  UserDefaultsHistoryStorageTests.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//


import XCTest
@testable import Currency_Exchange

class UserDefaultsHistoryStorageTests: XCTestCase {
    private var storage: UserDefaultsHistoryStorage!
    private let testKey = Constants.StorageKeys.conversionHistory

    override func setUp() {
        super.setUp()
        storage = UserDefaultsHistoryStorage()
        UserDefaults.standard.removeObject(forKey: testKey)
    }

    func testSaveAndLoadHistory() {
        let history = [
            ConversionHistory(sourceAmount: "100", sourceCurrency: "USD", destinationCurrency: "EUR", destinationAmount: "90", exchangeRate: 0.9, sourceCurrencyFlag: "🇺🇸", destinationCurrencyFlag: "🇪🇺")
        ]
        storage.save(history: history)
        
        let loadedHistory = storage.load()
        
        XCTAssertEqual(loadedHistory.count, 1)
        XCTAssertEqual(loadedHistory.first?.sourceAmount, "100")
        XCTAssertEqual(loadedHistory.first?.destinationCurrency, "EUR")
    }

    func testLoadEmptyHistory() {
        let loadedHistory = storage.load()
        XCTAssertTrue(loadedHistory.isEmpty)
    }
}
