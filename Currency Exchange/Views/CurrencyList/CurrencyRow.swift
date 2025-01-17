//
//  CurrencyRow.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//

import SwiftUI

struct CurrencyRow: View {
    let currency: Currency
    
    var body: some View {
        HStack {
            Text(currency.flag ?? "🏳️")
            Text(currency.name ?? Constants.Unknown)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 8)
    }
}
