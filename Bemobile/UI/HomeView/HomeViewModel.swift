//  HomeViewModel.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    // MARK: - Properties
    
    weak var view: HomeViewControllerProtocol?
    var router: HomeRouter?
    
    private var service: BemobileServiceProtocol
    
    private var transactions: [TransactionModel] = []
    private var rates = [RateModel]()
    
    // MARK: - Lifecycle
    
    init(_ service: BemobileServiceProtocol = BemobileService()) {
        self.service = service
    }
    
    // MARK: - Helpers
    
    func viewDidLoad() {
        fetchInfo()
        fetchRates()
    }
    
    func numberOfRowsIn(_ section: Int) -> Int {
        Set(transactions.compactMap({ $0.sku })).count
    }
    
    func infoForRowAt(_ indexPath: IndexPath) -> String {
        Array(Set(transactions.compactMap({ $0.sku })))[indexPath.row]
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let sku = Array(Set(transactions.compactMap({ $0.sku })))[indexPath.row]
        let selectedTransactions = transactions.filter({ $0.sku == sku })
        router?.showDetails(transactions: selectedTransactions, rates: rates)
    }
    
    private func fetchInfo() {
        service.fetch(.info) { [weak self ] (result: ResultResponse<[TransactionModel]>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let transactions):
                self.transactions = transactions
                self.view?.reload()
            case .failure(let error):
                print(error.message ?? "")
            }
        }
    }
    
    private func fetchRates() {
        service.fetch(.rate) { [weak self ] (result: ResultResponse<[RateModel]>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let rates):
                self.rates = rates
            case .failure(let error):
                print(error.message ?? "")
            }
        }
    }
    
}
