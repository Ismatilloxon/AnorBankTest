//
//  CurrencyModel.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import Foundation

enum CurrencyType: String, Codable, CaseIterable, Hashable {
    case uzs = "UZS"
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
    case jpy = "JPY"
    case gbp = "GBP"
    case chf = "CHF"
    case kzt = "KZT"
    case qar = "QAR"
}
