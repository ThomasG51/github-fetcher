//
//  BranchTableViewCell.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import UIKit

class BranchTableViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!

    func setupCell(name: String) {
        self.name.text = name
    }
}
