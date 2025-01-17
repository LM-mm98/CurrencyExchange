//
//  Model.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/12/25.
//

import Foundation

struct ExchangeRateResponse: Codable {
    var provider: String?
    var warningUpgradeToV6: String?
    var terms: String?
    var base: String?
    var date: String?
    var timeLastUpdated: Int?
    var rates: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case provider
        case warningUpgradeToV6 = "WARNING_UPGRADE_TO_V6"
        case terms
        case base
        case date
        case timeLastUpdated = "time_last_updated"
        case rates
    }
}

struct Currency: Identifiable {
    var id: String?
    var name: String?
    var flag: String?
    var sourceAmount: String?
    var destinationAmount: String?
    var sourceCurrency: String?
    var destinationCurrency: String?
    var exchangeRate: Double?
    
    static func flag(for currencyCode: String) -> String {
        let base: UInt32 = Constants.Flag_Base
        return currencyCode.uppercased().unicodeScalars.reduce("") {
            $0 + String(UnicodeScalar(base + $1.value)!)
        }
    }
}

struct ConversionHistory: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var sourceAmount: String
    var sourceCurrency: String
    var destinationCurrency: String
    var destinationAmount: String
    var exchangeRate: Double
    var sourceCurrencyFlag: String
    var destinationCurrencyFlag: String
}

struct SummaryViewData: Hashable {
    let conversionRate: Double
    let sourceAmount: String
    let sourceCurrency: String
    let destinationAmount: String
    let destinationCurrency: String
    let destinationFlag: String
}

struct CurrencyData {
    static let currencies: [Currency] = [
        Currency(id: Constants.ID_USD, name: Constants.United_States_Dollar, flag: Constants.Flag_USD, exchangeRate: nil),
        Currency(id: Constants.ID_MYR, name: Constants.Malaysian_Ringgit, flag: Constants.Flag_MYR, exchangeRate: nil),
        Currency(id: Constants.ID_VND, name: Constants.Vietnamese_Dong, flag: Constants.Flag_VND, exchangeRate: nil),
        Currency(id: Constants.ID_MMK, name: Constants.Myanmar_Kyat, flag: Constants.Flag_MMK, exchangeRate: nil),
        Currency(id: Constants.ID_IDR, name: Constants.Indonesian_Rupiah, flag: Constants.Flag_IDR, exchangeRate: nil)
    ]
}
