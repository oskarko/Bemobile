//  DetailsViewModel.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    // MARK: - Properties
    
    weak var view: DetailsViewControllerProtocol?
    var router: DetailsRouter?
    var infoDetail: BemobileModel?
    var infoRate: [RateModel]?
    // MARK: - Helpers
    
    
    func totalAmountInEuro() -> Double{
        let amount = infoDetail?.amount ?? 0.0
        let currency = infoDetail?.currency
        
        
        switch currency {
            
        case .aud:
            let toInr = infoRate?.first(where: {
                $0.from == "AUD" && $0.to == "INR"
            })
            let toEur = infoRate?.first(where: {$0.from == "INR" && $0.to == "EUR"})
            
            let acum = amount * (toInr?.rate ?? 0.0)
            return acum * (toEur?.rate ?? 0.0)
            
        case .cad:
            let toUsd = infoRate?.first(where: {$0.from == "CAD" && $0.to == "USD"})
            let toEur = infoRate?.first(where: {$0.from == "USD" && $0.to == "EUR"})
            
            let acum = amount * (toUsd?.rate ?? 0.0)
            return acum * (toEur?.rate ?? 0.0)
        case .eur:
            
            return amount
        case .gbp:
            
            let toEur = infoRate?.first(where: {
                $0.from == "GBP" && $0.to == "EUR"
            })
            
            
            return amount * (toEur?.rate ?? 0.0)
            
        case .inr:
            let toEur = infoRate?.first(where: {$0.from == "INR" && $0.to == "EUR"})
            
            return amount * (toEur?.rate ?? 0.0)
            
        case .jpy:
            
            let toUsd = infoRate?.first(where: {
                $0.from == "JPY" && $0.to == "USD"
            })
            let toEur = infoRate?.first(where: {$0.from == "USD" && $0.to == "EUR"})
            
            let acum = amount * (toUsd?.rate ?? 0.0)
            return acum * (toEur?.rate ?? 0.0)
        case .rub:
            
            let toSek = infoRate?.first(where: {
                $0.from == "RUB" && $0.to == "SEK"
            })
            let toUsd = infoRate?.first(where: {$0.from == "SEK" && $0.to == "USD"})
            let toEur = infoRate?.first(where: {$0.from == "USD" && $0.to == "EUR"})
            
            let acum = (amount * (toSek?.rate ?? 0.0)) * (toUsd?.rate ?? 0.0)
            return acum * (toEur?.rate ?? 0.0)
        case .sek:
            let toUsd = infoRate?.first(where: {$0.from == "SEK" && $0.to == "USD"})
            let toEur = infoRate?.first(where: {$0.from == "USD" && $0.to == "EUR"})
            
            let acum = amount * (toUsd?.rate ?? 0.0)
            return acum * (toEur?.rate ?? 0.0)
        case .usd:
            
            let toEur = infoRate?.first(where: {$0.from == "USD" && $0.to == "EUR"})
            return amount * (toEur?.rate ?? 0.0)
        case .none:
            break
        }
        
        return 0.0
    }
}
