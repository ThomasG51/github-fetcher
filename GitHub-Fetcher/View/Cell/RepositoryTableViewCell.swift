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

    func setupCell(name: String, language: String?, description: String?, stars: Int) {
        self.name.text = name
        self.language.text = language ?? ""
        self.repoDescription.text = description ?? "No description"
        self.stars.text = "⭐️ \(stars)"
    }
}
