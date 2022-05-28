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
    
    var repositories: Repositories?
    
    // MARK: - IBOutlet
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var repositoryTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = self
        
        viewModel.loadRealmObject { repositories in
            self.repositories = repositories
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailTableViewController {
            let detailVC = segue.destination as! DetailTableViewController
            let fullname = sender as! String
            detailVC.repository = fullname
        }
    }
}

// MARK: - UITableViewDelegate

extension RepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repositoryTableView.dequeueReusableCell(withIdentifier: repositoryCellID, for: indexPath) as! RepositoryTableViewCell
        
        if let repository = repositories?.items[indexPath.row] {
            cell.setupCell(repository: repository)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let repository = repositories?.items[indexPath.row] {
            performSegue(withIdentifier: "ShowDetailSegue", sender: repository.name)
        }
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
                
                self.repositories = repositories
                self.repositoryTableView.reloadData()
            }
        }
    }
}
