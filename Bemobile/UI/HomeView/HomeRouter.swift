//  HomeRouter.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import UIKit

final class HomeRouter {
    
    // MARK: - Properties
    
    weak var viewController: HomeViewController?
    
    // MARK: - Helpers
    
    static func getViewController() -> HomeViewController {
        let configuration = configureModule()
        
        return configuration.vc
    }
    
    private static func configureModule() -> (vc: HomeViewController, vm: HomeViewModel, rt: HomeRouter) {
        let viewController = HomeViewController()
        let router = HomeRouter()
        let viewModel = HomeViewModel()
        
        viewController.viewModel = viewModel
        
        viewModel.router = router
        viewModel.view = viewController
        
        router.viewController = viewController
        
        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
    func showDetails(transactions: [TransactionModel], rates: [RateModel]) {
        DispatchQueue.main.async {
            let detailsView = DetailsRouter.getViewController(transactions: transactions, rates: rates)
            self.viewController?.navigationController?.pushViewController(detailsView, animated: true)
        }
    }
    
}
