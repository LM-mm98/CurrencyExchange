//
//  HistoryRowView.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//

import SwiftUI

struct HistoryRowView: View {
    let entry: ConversionHistory
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(entry.sourceCurrency)
                    Text(entry.sourceAmount)
                        .fontWeight(.bold)
                }
                .padding(.bottom, 2)
                
                HStack {
                    Text(entry.destinationCurrency)
                    Text(entry.destinationAmount)
                        .fontWeight(.bold)
                }
            }
            Spacer()
            VStack {
                Text(Constants.HistoryListView.rateLabel)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(String(entry.exchangeRate))
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }
        .padding(.vertical, 8)
    }
}
