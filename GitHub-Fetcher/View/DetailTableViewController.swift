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
    var contributors: [Contributor]?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadBranch()
        loadContributor()
    }

    // MARK: - Private Func

    private func loadBranch() {
        viewModel.fetchBranch(for: repository) { branches, error in
            DispatchQueue.main.async {
                self.branches = branches
                self.tableView.reloadData()
            }
        }
    }

    private func loadContributor() {
        viewModel.fetchContributor(for: repository) { contributors, error in
            DispatchQueue.main.async {
                self.contributors = contributors
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
        if section == 0 {
            return branches?.count ?? 0
        }
        return contributors?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: branchCellID, for: indexPath) as! BranchTableViewCell

            if let branch = branches?[indexPath.row] {
                cell.setupCell(name: branch.name)
            }

            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: contributorCellID, for: indexPath) as! ContributorTableViewCell

        if let contributor = contributors?[indexPath.row] {
            cell.setupCell(contributor: contributor)
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
