//
//  Double + Extension.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/14/25.
//

import Foundation

extension Double {
    public func formatExchangeRate() -> String {
        if self < 1.0 {
            return "\(self)" // No formatting for values less than 1
        }
        return String(format: "%.2f", self) // Two decimal places for larger values
    }
}



