//
//  TransactionModel.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct TransactionModel: Codable {
    let sku: String
    let amount: Double
    let currency: Currency
}

enum Currency: String, Codable {
    case aud = "AUD"
    case cad = "CAD"
    case eur = "EUR"
    case gbp = "GBP"
    case inr = "INR"
    case jpy = "JPY"
    case rub = "RUB"
    case sek = "SEK"
    case usd = "USD"
}
