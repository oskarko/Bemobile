//  DetailsViewController.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailsViewModel!
    
    @IBOutlet weak var tableViewDetails: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
    }
    
    // MARK: - Helpers

    private func configureUI() {
        tableViewDetails.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewDetails.rowHeight = 50.0
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsIn(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.infoForRowAt(indexPath)
        cell.contentConfiguration = content
        
        return cell
    }
    
}

// MARK: - DetailsViewControllerProtocol

protocol DetailsViewControllerProtocol: AnyObject { }
extension DetailsViewController: DetailsViewControllerProtocol { }
