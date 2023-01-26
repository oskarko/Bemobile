//
//  BemobileModel.swift
//  Bemobile
//
//  Created by Guadalupe Morales carmona on 26/1/23.
//

import Foundation

struct BemobileModel : Codable {
    let sku: String
    let amount: Double
    let currency: Currency
}

enum Currency: String, Codable{
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


