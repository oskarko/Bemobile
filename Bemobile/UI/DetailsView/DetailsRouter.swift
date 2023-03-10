//  DetailsRouter.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

final class DetailsRouter {
    
    // MARK: - Properties
    
    weak var viewController: DetailsViewController?

    // MARK: - Helpers
    
    static func getViewController(transactions: [TransactionModel], rates: [RateModel]) -> DetailsViewController {
        let configuration = configureModule(transactions: transactions, rates: rates)

        return configuration.vc
    }
    
    private static func configureModule(transactions: [TransactionModel],
                                        rates: [RateModel]) -> (vc: DetailsViewController, vm: DetailsViewModel, rt: DetailsRouter) {
        let viewController = DetailsViewController()
        let router = DetailsRouter()
        let viewModel = DetailsViewModel(transactions: transactions, rates: rates)

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}
