//
//  CurrencyConversionView.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/13/25.
//

import SwiftUI

struct CurrencyConversionView: View {
    @StateObject private var viewModel: CurrencyConversionViewModel
    @FocusState private var focusedField: FocusableField?
    
    enum FocusableField {
        case sourceAmount
        case destinationAmount
    }
    
    init(sourceCurrency: Currency, destinationCurrency: Currency, prefilledHistory: ConversionHistory? = nil) {
        let viewModel = CurrencyConversionViewModel(
            sourceCurrency: sourceCurrency,
            destinationCurrency: destinationCurrency
        )
        if let history = prefilledHistory {
            viewModel.prefillData(from: history)
        }
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("\(Constants.CurrencyConversionView.exchangeRateLabel) \(viewModel.destinationCurrency.exchangeRate?.formatExchangeRate() ?? Constants.CurrencyConversionView.exchangeRateUnavailable)")
                .font(.headline)
                .padding(.bottom, 8)
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text(viewModel.sourceCurrency.id ?? Constants.CurrencyConversionView.sourceCurrencyPlaceholder)
                    TextField(Constants.CurrencyConversionView.enterAmountPlaceholder, text: $viewModel.sourceAmount, onEditingChanged: { editing in
                        if !editing {
                            viewModel.saveToHistory()
                        }
                    })
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .sourceAmount)
                    .onTapGesture {
                        focusedField = .sourceAmount
                    }
                    .onChange(of: viewModel.sourceAmount) { oldValue, newValue in
                        if viewModel.validateSourceInput() {
                            viewModel.updateDestinationAmount()
                        } else if focusedField == .sourceAmount {
                            viewModel.destinationAmount = ""
                        }
                    }
                    
                    if focusedField == .sourceAmount, let errorMessage = viewModel.sourceErrorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                HStack {
                    Spacer()
                    Image(systemName: Constants.CurrencyConversionView.exchangeIconName)
                        .font(.title2)
                        .foregroundColor(.gray)
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text(viewModel.destinationCurrency.id ?? Constants.CurrencyConversionView.destinationCurrencyPlaceholder)
                    TextField(Constants.CurrencyConversionView.convertedAmountPlaceholder, text: $viewModel.destinationAmount, onEditingChanged: { editing in
                        if !editing {
                            viewModel.saveToHistory()
                        }
                    })
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .destinationAmount)
                    .onTapGesture {
                        focusedField = .destinationAmount
                    }
                    .onChange(of: viewModel.destinationAmount) { oldValue, newValue in
                        if viewModel.validateDestinationInput() {
                            viewModel.updateSourceAmount()
                        } else if focusedField == .destinationAmount {
                            viewModel.sourceAmount = ""
                        }
                    }
                    
                    if focusedField == .destinationAmount, let errorMessage = viewModel.destinationErrorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
            .padding()
            
            Spacer()
            
            summaryLink
        }
        .padding()
        .navigationTitle(Constants.CurrencyConversionView.navigationTitle)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

extension CurrencyConversionView {
    private var summaryLink: some View {
        NavigationLink(
            destination: SummaryView(
                conversionRate: viewModel.destinationCurrency.exchangeRate ?? 0.0,
                sourceAmount: viewModel.sourceAmount,
                sourceCurrency: viewModel.sourceCurrency.id ?? Constants.CurrencyConversionView.exchangeRateUnavailable,
                sourceFlag: viewModel.sourceCurrency.flag ?? "🏳️",
                destinationAmount: viewModel.destinationAmount,
                destinationCurrency: viewModel.destinationCurrency.id ?? Constants.CurrencyConversionView.exchangeRateUnavailable,
                destinationFlag: viewModel.destinationCurrency.flag ?? "🏳️"
            )
        ) {
            Text(Constants.CurrencyConversionView.summaryButtonTitle)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(viewModel.canProceedToSummary ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(!viewModel.canProceedToSummary)
        .padding(.horizontal)
    }
}

