//  DetailsViewModel.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

final class DetailsViewModel {
    
    // MARK: - Properties
    
    weak var view: DetailsViewControllerProtocol?
    var router: DetailsRouter?
    
    private var transactions: [TransactionModel]
    private var rates: [RateModel]
    
    // MARK: - Lifecycle
    
    init(transactions: [TransactionModel], rates: [RateModel]) {
        self.transactions = transactions
        self.rates = rates
    }
    
    // MARK: - Helpers
    
    func numberOfRowsIn(_ section: Int) -> Int {
        transactions.count + 1
    }
    
    func infoForRowAt(_ indexPath: IndexPath) -> String {
        if indexPath.row < transactions.count {
            let transaction = transactions[indexPath.row]
            
            return "\(roundFormat(transaction.amount)) \(transaction.currency.rawValue)"
        } else {
            return "Total: \(String(totalAmountInEuro())) EUR"
        }
    }
    
    private func convertToEuro(transaction: TransactionModel) -> Double {
        let amount = transaction.amount
        let currency = transaction.currency
        
        switch currency {
        case .aud:
            let toInr = rates.first(where: {
                $0.from == "AUD" && $0.to == "INR"
            })
            let toEur = rates.first(where: {$0.from == "INR" && $0.to == "EUR"})
            let acum = amount * (toInr?.rate ?? 0.0)
            
            return acum * (toEur?.rate ?? 0.0)
        case .cad:
            let toUsd = rates.first(where: {$0.from == "CAD" && $0.to == "USD"})
            let toEur = rates.first(where: {$0.from == "USD" && $0.to == "EUR"})
            
            let acum = amount * (toUsd?.rate ?? 0.0)
            
            return acum * (toEur?.rate ?? 0.0)
        case .eur:
            return amount
        case .gbp:
            let toEur = rates.first(where: {
                $0.from == "GBP" && $0.to == "EUR"
            })
            
            return amount * (toEur?.rate ?? 0.0)
        case .inr:
            let toEur = rates.first(where: {$0.from == "INR" && $0.to == "EUR"})
            
            return amount * (toEur?.rate ?? 0.0)
        case .jpy:
            let toUsd = rates.first(where: {
                $0.from == "JPY" && $0.to == "USD"
            })
            let toEur = rates.first(where: {$0.from == "USD" && $0.to == "EUR"})
            let acum = amount * (toUsd?.rate ?? 0.0)
            
            return acum * (toEur?.rate ?? 0.0)
        case .rub:
            let toSek = rates.first(where: {
                $0.from == "RUB" && $0.to == "SEK"
            })
            let toUsd = rates.first(where: {$0.from == "SEK" && $0.to == "USD"})
            let toEur = rates.first(where: {$0.from == "USD" && $0.to == "EUR"})
            let acum = (amount * (toSek?.rate ?? 0.0)) * (toUsd?.rate ?? 0.0)
            
            return acum * (toEur?.rate ?? 0.0)
        case .sek:
            let toUsd = rates.first(where: {$0.from == "SEK" && $0.to == "USD"})
            let toEur = rates.first(where: {$0.from == "USD" && $0.to == "EUR"})
            let acum = amount * (toUsd?.rate ?? 0.0)
            
            return acum * (toEur?.rate ?? 0.0)
        case .usd:
            let toEur = rates.first(where: {$0.from == "USD" && $0.to == "EUR"})
            
            let total = amount * (toEur?.rate ?? 0.0)
            let roundedTotal = round(total * 100) / 100.0
            
            return roundedTotal
        }

    }
    
    private func totalAmountInEuro() -> Double {
        var acum = 0.0
        
        for transaction in transactions {
            acum += convertToEuro(transaction: transaction)
        }
        
        let roundedTotalEuros = roundFormat(acum)
        
        return roundedTotalEuros
    }
    
    private func roundFormat(_ value: Double) -> Double {
        round(value * 100) / 100.0
    }
}
