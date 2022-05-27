//
//  DetailTableViewController.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import UIKit

class DetailTableViewController: UITableViewController {
    // MARK: - Property

    let branchCellID = "BranchCellIdentifier"
    let contributorCellID = "ContributorCellIdentifier"
    let viewModel = DetailViewModel()

    var repository: String!
    var branches: [Branch]?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadBranch()
    }

    // MARK: - Private Func

    private func loadBranch() {
        viewModel.fetchBranch(for: repository) { branches, error in
            DispatchQueue.main.async {
                if error != nil, error == .rateLimit {
                    let alert = UIAlertController(title: "⚠️ Warning", message: "API rate limit exceeded.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }

                self.branches = branches
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView

extension DetailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branches?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: branchCellID, for: indexPath) as! BranchTableViewCell

        if let branch = branches?[indexPath.row] {
            cell.setupCell(name: branch.name)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Branch"
        }

        return "Contributor"
    }
}
