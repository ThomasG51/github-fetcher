//
//  RepositoryViewController.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import UIKit

class RepositoryViewController: UIViewController {
    // MARK: - Property
    
    let repositoryCellID = "RepositoryCellIdentifier"
    
    // MARK: - IBOutlet
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var repositoryTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate

extension RepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repositoryTableView.dequeueReusableCell(withIdentifier: repositoryCellID, for: indexPath) as! RepositoryTableViewCell
        cell.setupCell(name: "Setup/TV", language: "Swift", description: "Setup repository table view", stars: 100)
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension RepositoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
