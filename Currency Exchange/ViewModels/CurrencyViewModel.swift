//
//  CurrencyViewModel.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/12/25.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    @Published var sourceCurrencies: [Currency]
    
    init(sourceCurrencies: [Currency]) {
        self.sourceCurrencies = sourceCurrencies
    }
}
