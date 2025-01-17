//
//  Decimal + Extension.swift
//  Currency Exchange
//
//  Created by Lin Myat on 1/17/25.
//

import Foundation

extension Decimal {
    public func formatToTwoDecimalPlaces() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = false
        return formatter.string(for: self) ?? "\(self)"
    }
}
