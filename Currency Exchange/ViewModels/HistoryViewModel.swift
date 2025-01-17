//
//  HistoryViewModel.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//


import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var history: [ConversionHistory] = []
    @Published var selectedHistory: ConversionHistory?
    
    func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: Constants.StorageKeys.conversionHistory),
           let savedHistory = try? JSONDecoder().decode([ConversionHistory].self, from: data) {
            history = savedHistory
        } else {
            history = [] // Ensure history is empty if no data is found
        }
    }
}
