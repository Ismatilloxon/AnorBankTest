//
//  ExchangeRates.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import Foundation

// MARK: - ExchangeRates
struct ExchangeRates: Codable {
    let result: String
    let baseCode: String
    let rates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case result
        case baseCode = "base_code"
        case rates = "conversion_rates"
    }
}
