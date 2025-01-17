//
//  DestinationCurrencyList.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//

import SwiftUI

struct DestinationCurrencyList<Content: View>: View {
    let currencies: [Currency]
    let navigationDestination: (Currency) -> Content
    
    var body: some View {
        List(currencies) { currency in
            NavigationLink(destination: navigationDestination(currency)) {
                HStack {
                    Text(currency.flag ?? "🏳️")
                    VStack(alignment: .leading) {
                        Text(currency.name ?? Constants.Unknown)
                        if let exchangeRate = currency.exchangeRate {
                            Text(exchangeRate.formatExchangeRate())
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
}
