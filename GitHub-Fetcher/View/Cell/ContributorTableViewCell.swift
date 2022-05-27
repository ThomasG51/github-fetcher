//
//  ContributorTableViewCell.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import UIKit

class ContributorTableViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var avatar: UIImageView!

    func setupCell(contributor: Contributor) {
        name.text = contributor.login
        avatar.layer.cornerRadius = avatar.frame.size.height / 2
        if let url = URL(string: contributor.avatar) {
            avatar.load(url: url)
        }
    }
}
