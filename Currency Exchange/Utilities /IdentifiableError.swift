//
//  IdentifiableError.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/13/25.
//


import Foundation

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}

enum CurrencyServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return Constants.ErrorMessages.invalidURL
        case .invalidResponse:
            return Constants.ErrorMessages.invalidResponse
        case .decodingError:
            return Constants.ErrorMessages.decodingError
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}
