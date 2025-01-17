//
//  CurrencyConversionViewModel.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/13/25.
//

import Foundation

class CurrencyConversionViewModel: ObservableObject {
    @Published var sourceAmount: String = ""
    @Published var destinationAmount: String = ""
    @Published var sourceErrorMessage: String? = nil
    @Published var destinationErrorMessage: String? = nil
    @Published var history: [ConversionHistory] = []
    
    var sourceCurrency: Currency
    var destinationCurrency: Currency
    
    private let historyStorage: HistoryStorage
    private var preciseSourceAmount: Decimal = 0
    private var preciseDestinationAmount: Decimal = 0
    private var preciseValueMapping: [String: Decimal] = [:]
    
    var canProceedToSummary: Bool {
        !sourceAmount.isEmpty && !destinationAmount.isEmpty
    }
    
    // MARK: - Initializer
    init(
        sourceCurrency: Currency,
        destinationCurrency: Currency,
        historyStorage: HistoryStorage = UserDefaultsHistoryStorage()
    ) {
        self.sourceCurrency = sourceCurrency
        self.destinationCurrency = destinationCurrency
        self.historyStorage = historyStorage
        loadHistory()
    }
}

// MARK: - Input Validation
extension CurrencyConversionViewModel {
    func validateSourceInput() -> Bool {
        validateInput(value: sourceAmount, errorMessage: &sourceErrorMessage)
    }
    
    func validateDestinationInput() -> Bool {
        validateInput(value: destinationAmount, errorMessage: &destinationErrorMessage)
    }
    
    private func validateInput(value: String, errorMessage: inout String?) -> Bool {
        errorMessage = generateErrorMessage(for: value)
        return errorMessage == nil
    }
    
    private func generateErrorMessage(for value: String) -> String? {
        guard let numericValue = Double(value), numericValue >= 10 else {
            return Constants.ErrorMessages.valueTooLow
        }
        return nil
    }
}

// MARK: - Conversion Logic
extension CurrencyConversionViewModel {
    func updateDestinationAmount() {
        guard let exchangeRate = destinationCurrency.exchangeRate,
              let sourceValue = Decimal(string: sourceAmount) else {
            destinationAmount = ""
            return
        }
        
        let preciseValue = preciseValueMapping[sourceAmount] ?? sourceValue
        calculateDestinationAmount(using: preciseValue, exchangeRate: Decimal(exchangeRate))
    }
    
    func updateSourceAmount() {
        guard let exchangeRate = destinationCurrency.exchangeRate,
              let destinationValue = Decimal(string: destinationAmount) else {
            sourceAmount = ""
            return
        }
        
        let preciseValue = preciseValueMapping[destinationAmount] ?? destinationValue
        calculateSourceAmount(using: preciseValue, exchangeRate: Decimal(exchangeRate))
    }
    
    private func calculateDestinationAmount(using preciseValue: Decimal, exchangeRate: Decimal) {
        preciseSourceAmount = preciseValue
        let calculatedValue = preciseSourceAmount * exchangeRate
        preciseDestinationAmount = calculatedValue
        updateFormattedAmount(calculatedValue, for: &destinationAmount)
    }
    
    private func calculateSourceAmount(using preciseValue: Decimal, exchangeRate: Decimal) {
        preciseDestinationAmount = preciseValue
        let calculatedValue = preciseDestinationAmount / exchangeRate
        preciseSourceAmount = calculatedValue
        updateFormattedAmount(calculatedValue, for: &sourceAmount)
    }
    
    private func updateFormattedAmount(_ value: Decimal, for field: inout String) {
        let formattedValue = value.formatToTwoDecimalPlaces()
        field = formattedValue
        preciseValueMapping[formattedValue] = value
    }
}

// MARK: - History Management
extension CurrencyConversionViewModel {
    func saveToHistory() {
        guard isValidConversion() else { return }
        
        let newEntry = ConversionHistory(
            sourceAmount: sourceAmount,
            sourceCurrency: sourceCurrency.id ?? "",
            destinationCurrency: destinationCurrency.id ?? "",
            destinationAmount: destinationAmount,
            exchangeRate: destinationCurrency.exchangeRate ?? 0,
            sourceCurrencyFlag: sourceCurrency.flag ?? "🏳️",
            destinationCurrencyFlag: destinationCurrency.flag ?? "🏳️"
        )
        
        guard shouldSaveNewEntry(newEntry) else { return }
        
        addToHistory(newEntry)
        saveHistory()
    }
    
    private func isValidConversion() -> Bool {
        !sourceAmount.isEmpty && !destinationAmount.isEmpty && destinationCurrency.exchangeRate != nil
    }
    
    private func shouldSaveNewEntry(_ newEntry: ConversionHistory) -> Bool {
        if let lastEntry = history.first {
            return lastEntry.sourceAmount != newEntry.sourceAmount ||
            lastEntry.destinationAmount != newEntry.destinationAmount
        }
        return true
    }
    
    func addToHistory(_ newEntry: ConversionHistory) {
        history.insert(newEntry, at: 0)
        if history.count > 10 {
            history.removeLast()
        }
    }
    
    private func saveHistory() {
        historyStorage.save(history: history)
    }
    
    private func loadHistory() {
        history = historyStorage.load()
    }
}

extension CurrencyConversionViewModel {
    func prefillData(from history: ConversionHistory) {
        sourceAmount = history.sourceAmount
        sourceCurrency.id = history.sourceCurrency
        destinationCurrency.id = history.destinationCurrency
        destinationCurrency.exchangeRate = history.exchangeRate
        sourceCurrency.flag = history.sourceCurrencyFlag
        destinationCurrency.flag = history.destinationCurrencyFlag
        destinationAmount = history.destinationAmount
    }
}
