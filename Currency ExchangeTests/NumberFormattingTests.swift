//
//  NumberFormattingTests.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//


import XCTest

class NumberFormattingTests: XCTestCase {
    
    func testDecimalFormatToTwoDecimalPlaces() {
        // Arrange
        let decimal1: Decimal = 1234.5678
        let decimal2: Decimal = 1234.0
        let decimal3: Decimal = 0.12
        let decimal4: Decimal = 0.0
        
        // Act & Assert
        XCTAssertEqual(decimal1.formatToTwoDecimalPlaces(), "1234.57", "Should round to two decimal places.")
        XCTAssertEqual(decimal2.formatToTwoDecimalPlaces(), "1234", "Should show no decimal places if none are needed.")
        XCTAssertEqual(decimal3.formatToTwoDecimalPlaces(), "0.12", "Should show exactly two decimal places.")
        XCTAssertEqual(decimal4.formatToTwoDecimalPlaces(), "0", "Should format zero correctly.")
    }
    
    func testDoubleFormatExchangeRate() {
        // Arrange
        let value1: Double = 1234.5678
        let value2: Double = 0.12345
        let value3: Double = 1.0
        let value4: Double = 0.0
        
        // Act & Assert
        XCTAssertEqual(value1.formatExchangeRate(), "1234.57", "Should round to two decimal places for values >= 1.")
        XCTAssertEqual(value2.formatExchangeRate(), "0.12345", "Should not apply rounding for values < 1.")
        XCTAssertEqual(value3.formatExchangeRate(), "1.00", "Should show two decimal places for exactly 1.")
        XCTAssertEqual(value4.formatExchangeRate(), "0.0", "Should show exact representation for zero.")
    }
}