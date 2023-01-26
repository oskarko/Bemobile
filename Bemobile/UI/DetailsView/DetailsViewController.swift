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
    var infoDetail: [BemobileModel]?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
      
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {
 
    }
    
}

// MARK: - DetailsViewControllerProtocol

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (infoDetail?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let info = infoArray[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = info
        //content.secondaryText = String(info.amount) + info.currency.rawValue
        cell.contentConfiguration = content
        cell.backgroundColor = .white
        return cell
    }
    
    
}

extension DetailsViewController: DetailsViewControllerProtocol {

}
