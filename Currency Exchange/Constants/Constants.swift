//
//  Constants.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//

import Foundation

struct Constants {
    static let ExchangeRateAPIBaseURL = "https://api.exchangerate-api.com/v4/latest/"
    // Currency IDs
    static let ID_USD = "USD"
    static let ID_MYR = "MYR"
    static let ID_VND = "VND"
    static let ID_MMK = "MMK"
    static let ID_IDR = "IDR"
    
    // Currency Names
    static let United_States_Dollar = "United States Dollar"
    static let Malaysian_Ringgit = "Malaysian Ringgit"
    static let Vietnamese_Dong = "Vietnamese Dong"
    static let Myanmar_Kyat = "Myanmar Kyat"
    static let Indonesian_Rupiah = "Indonesian Rupiah"
    static let Unknown = "Unknown Currency"
    
    // Currency Flags
    static let Flag_USD = "🇺🇸"
    static let Flag_MYR = "🇲🇾"
    static let Flag_VND = "🇻🇳"
    static let Flag_MMK = "🇲🇲"
    static let Flag_IDR = "🇮🇩"
    
    static let Flag_Base: UInt32 = 127397
    
    struct ErrorMessages {
        static let invalidURL = "The URL is invalid."
        static let invalidResponse = "The server returned an invalid response."
        static let decodingError = "Failed to decode the response."
        static let valueTooLow = "The value must be greater than or equal to 10."
        static let invalidId = "Invalid source currency ID."
    }
    
    struct StorageKeys {
        static let conversionHistory = "conversionHistory"
    }
    
    struct CurrencyConversionView {
        static let exchangeRateLabel = "Exchange Rate:"
        static let sourceCurrencyPlaceholder = "Source Currency"
        static let destinationCurrencyPlaceholder = "Destination Currency"
        static let enterAmountPlaceholder = "Enter amount"
        static let convertedAmountPlaceholder = "Converted amount"
        static let exchangeRateUnavailable = "N/A"
        static let navigationTitle = "Currency Conversion"
        static let summaryButtonTitle = "Summary"
        static let exchangeIconName = "arrow.up.arrow.down"
    }
    
    struct CurrencyListView {
        static let navigationTitle = "Source Currencies"
        static let historyButtonTitle = "History"
        static let unknownCurrency = "Unknown Currency"
    }
    
    struct DestinationCurrencyListView {
        static let loadingMessage = "Fetching exchange rates..."
        static let navigationTitle = "Destination Currencies"
    }
    
    struct ErrorSheet {
        static let title = "Error"
        static let unknownErrorMessage = "An unknown error occurred."
        static let dismissButtonTitle = "Dismiss"
    }
    
    struct HistoryListView {
        static let navigationTitle = "Conversion History"
        static let emptyStateImageName = "tray"
        static let emptyStateMessage = "No conversion history available"
        static let rateLabel = "Rate"
    }
    
    struct SummaryView {
        static let navigationTitle = "Summary"
        static let conversionSummaryTitle = "Conversion Summary"
        static let sourceAmountLabel = "Source Amount: "
        static let convertedAmountLabel = "Converted Amount: "
        static let exchangeRateLabel = "Exchange Rate: 1"
        static let saveAndShareButton = "Save & Share"
        static let goToHomeScreenButton = "Go to Home Screen"
        static let saveAndShareError = "Error: Unable to access the root view or window scene."
        static let captureError = "Error: Failed to capture the view as an image."
    }
}

