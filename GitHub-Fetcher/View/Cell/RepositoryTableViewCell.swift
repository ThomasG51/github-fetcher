//
//  RepositoryTableViewCell.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var language: UILabel!
    @IBOutlet var repoDescription: UILabel!
    @IBOutlet var stars: UILabel!

    func setupCell(repository: Repositories.Repository) {
        self.name.text = repository.name
        self.language.text = repository.language ?? ""
        self.repoDescription.text = repository.description ?? "No description"
        self.stars.text = "⭐️ \(repository.stars)"
    }
}
