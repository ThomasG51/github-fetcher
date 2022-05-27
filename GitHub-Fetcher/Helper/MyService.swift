//
//  MyService.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import Foundation
import Moya

enum MyService {
    case fetchRepository(name: String)
    case fetchBranch(repository: String)
    case fetchContributor(repository: String)
}

extension MyService: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }

    var path: String {
        switch self {
        case .fetchRepository:
            return "/search/repositories"
        case .fetchBranch(repository: let repository):
            return "/repos/\(repository.lowercased())/branches"
        case .fetchContributor(repository: let repository):
            return "/repos/\(repository.lowercased())/contributors"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchRepository, .fetchBranch, .fetchContributor:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .fetchBranch, .fetchContributor:
            return .requestPlain
        case .fetchRepository(let name):
            return .requestParameters(parameters: ["q": name], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
