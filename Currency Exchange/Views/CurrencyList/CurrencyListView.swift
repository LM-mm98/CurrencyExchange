//
//  CurrencyListView.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/13/25.
//

import SwiftUI

struct CurrencyListView: View {
    @ObservedObject var viewModel: CurrencyViewModel
    let service: CurrencyServiceProtocol
    
    var body: some View {
        NavigationView {
            List(viewModel.sourceCurrencies) { currency in
                NavigationLink(
                    destination: DestinationCurrencyListView(
                        sourceCurrency: currency,
                        service: service,
                        sourceCurrencies: viewModel.sourceCurrencies
                    )
                ) {
                    CurrencyRow(currency: currency)
                }
            }
            .navigationTitle(Constants.CurrencyListView.navigationTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: HistoryListView(
                            viewModel: HistoryViewModel()
                        )
                    ) {
                        Text(Constants.CurrencyListView.historyButtonTitle)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

