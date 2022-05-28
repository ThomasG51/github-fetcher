//
//  Repositories.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import Foundation
import RealmSwift

class Repositories: Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var id: Int? = 1
    @Persisted var items: List<Repository>
}

class Repository: EmbeddedObject, ObjectKeyIdentifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name = "full_name"
        case repoDescription = "description"
        case language
        case stars = "stargazers_count"
    }

    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var repoDescription: String?
    @Persisted var language: String?
    @Persisted var stars: Int
}
