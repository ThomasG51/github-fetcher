//
//  Contributor.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import Foundation

struct Contributor: Codable {
    enum CodingKeys: String, CodingKey {
        case login
        case avatar = "avatar_url"
    }

    let login: String
    let avatar: String
}
