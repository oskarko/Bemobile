//  HomeViewController.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {

}

class HomeViewController: UIViewController {
 
    
    
    // MARK: - Properties
    
    var viewModel: HomeViewModel!
    var manager = BemobileManager()
    var infoAPI: [BemobileModel] = []

    
   lazy var tableView : UITableView = {
        
       let tableView = UITableView()
       tableView.delegate = self
       tableView.dataSource = self
       tableView.rowHeight = 80.0
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       tableView.translatesAutoresizingMaskIntoConstraints = false
       return tableView
   }()
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        manager.delegate = self
        configureUI()
        manager.fetch()
       
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        var topPadding : CGFloat = 0.0
        if let topInset = UIApplication.shared.windows.first?.safeAreaInsets.top{
            topPadding = topInset
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
   
    }
    
}

// MARK: - HomeViewControllerProtocol
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.router?.showDetails(info: infoAPI[indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let info = infoAPI[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = info.sku
        content.secondaryText = String(info.amount) + info.currency.rawValue
        cell.contentConfiguration = content
        cell.backgroundColor = .white
        return cell
        
      
    }
    
}
// MARK: - Delegado
extension HomeViewController: BemobileManagerDelegate {
    
    func didUpdateRate(info: [BemobileModel]) {
        
    }
    
    
     
    func didUpdateInfo(info: [BemobileModel]) {
        infoAPI = info
        tableView.reloadData()
//        DispatchQueue.main.async {
//            self.infoAPI = info
//            self.tableView.reloadData()
//        }
      
        
    }

}

extension HomeViewController: HomeViewControllerProtocol {

}
