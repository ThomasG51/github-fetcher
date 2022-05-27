//
//  Repositories.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import Foundation

struct Repositories: Codable {
    let items: [Repository]
    struct Repository: Codable {
        enum CodingKeys: String, CodingKey {
            case id
            case name = "full_name"
            case description
            case language
            case stars = "stargazers_count"
        }

        let id: Int
        let name: String
        let description: String?
        let language: String?
        let stars: Int
    }
}
