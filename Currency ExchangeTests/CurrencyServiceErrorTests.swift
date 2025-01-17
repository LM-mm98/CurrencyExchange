//
//  CurrencyServiceErrorTests.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//


import XCTest
@testable import Currency_Exchange

class CurrencyServiceErrorTests: XCTestCase {

    struct MockConstants {
        struct ErrorMessages {
            static let invalidURL = "Invalid URL"
            static let invalidResponse = "Invalid response from server"
            static let decodingError = "Failed to decode response"
        }
    }
    
    func testErrorDescriptions() {
        // Arrange
        let errors: [(CurrencyServiceError, String)] = [
            (.invalidURL, MockConstants.ErrorMessages.invalidURL),
            (.invalidResponse, MockConstants.ErrorMessages.invalidResponse),
            (.decodingError, MockConstants.ErrorMessages.decodingError),
            (.networkError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Network failure"])), "Network failure")
        ]
        
        // Act & Assert
        for (error, expectedDescription) in errors {
            XCTAssertEqual(error.errorDescription, expectedDescription, "Expected \(expectedDescription), but got \(String(describing: error.errorDescription)) for \(error)")
        }
    }
}
