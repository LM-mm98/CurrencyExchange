//
//  HistoryListView.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/15/25.
//

import SwiftUI

struct HistoryListView: View {
    @ObservedObject var viewModel: HistoryViewModel
    
    var body: some View {
        VStack {
            if viewModel.history.isEmpty {
                emptyStateView
            } else {
                List(selection: $viewModel.selectedHistory) {
                    ForEach(viewModel.history) { entry in
                        NavigationLink(
                            destination: CurrencyConversionView(
                                sourceCurrency: Currency(
                                    id: entry.sourceAmount,
                                    sourceCurrency: entry.sourceCurrency
                                ),
                                destinationCurrency: Currency(
                                    id: entry.destinationAmount,
                                    destinationCurrency: entry.destinationCurrency
                                ),
                                prefilledHistory: entry
                            )
                        ) {
                            HistoryRowView(entry: entry)
                        }
                    }
                }
            }
        }
        .navigationTitle(Constants.HistoryListView.navigationTitle)
        .onAppear {
            viewModel.loadHistory()
        }
    }
    
    private var emptyStateView: some View {
        VStack {
            Image(systemName: Constants.HistoryListView.emptyStateImageName)
                .font(.largeTitle)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            Text(Constants.HistoryListView.emptyStateMessage)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

