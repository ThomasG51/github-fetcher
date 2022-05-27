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
    let viewModel = RepositoryViewModel()
    
    var repositories: [Repositories.Repository]?
    
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
        return repositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repositoryTableView.dequeueReusableCell(withIdentifier: repositoryCellID, for: indexPath) as! RepositoryTableViewCell
        
        if let repositories = repositories {
            cell.setupCell(
                name: repositories[indexPath.row].name,
                language: repositories[indexPath.row].language,
                description: repositories[indexPath.row].description,
                stars: repositories[indexPath.row].stars
            )
        }
        
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension RepositoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 0 else { return }
        viewModel.fetchRepository(by: searchText) { repositories, error in
            DispatchQueue.main.async {
                if error != nil, error == .rateLimit {
                    let alert = UIAlertController(title: "⚠️ Warning", message: "API rate limit exceeded.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
                
                self.repositories = repositories?.items
                self.repositoryTableView.reloadData()
            }
        }
    }
}
