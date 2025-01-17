//
//  UserDefaultsHistoryStorage.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//

import Foundation

protocol HistoryStorage {
    func save(history: [ConversionHistory])
    func load() -> [ConversionHistory]
}

class UserDefaultsHistoryStorage: HistoryStorage {
    private let key = Constants.StorageKeys.conversionHistory
    
    func save(history: [ConversionHistory]) {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func load() -> [ConversionHistory] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let savedHistory = try? JSONDecoder().decode([ConversionHistory].self, from: data) else {
            return []
        }
        return savedHistory
    }
}
