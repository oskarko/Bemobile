//  DetailsViewController.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol DetailsViewControllerProtocol: AnyObject {

}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableViewDetails: UITableView!
    // MARK: - Properties
    
    var viewModel: DetailsViewModel!
    var infoDetail = [BemobileModel]()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
      
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {
        self.infoDetail = viewModel.infoDetail ?? []
        tableViewDetails.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
 
    }
    
}

// MARK: - DetailsViewControllerProtocol

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return infoDetail.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == infoDetail.count {
            var content = cell.defaultContentConfiguration()
            content.text = "total: " + String(viewModel.totalAmountInEuro()) +  "EUR"
            cell.contentConfiguration = content
            return cell
        }
        let info = infoDetail[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = String(info.amount) + (info.currency.rawValue)
        cell.contentConfiguration = content
        return cell
    }
    
    
}

extension DetailsViewController: DetailsViewControllerProtocol {

}
