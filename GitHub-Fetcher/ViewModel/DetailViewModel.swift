//
//  DetailViewModel.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import Foundation
import Moya

class DetailViewModel {
    func fetchBranch(for repository: String, completion: @escaping ([Branch]?, ApiError?) -> Void) {
        let provider = MoyaProvider<MyService>()
        provider.request(.fetchBranch(repository: repository)) { result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                if statusCode == 403 {
                    print("Rate limit error")
                    completion(nil, ApiError.rateLimit)
                    return
                }

                let data = moyaResponse.data
                do {
                    let branches = try JSONDecoder().decode([Branch].self, from: data)
                    completion(branches, nil)
                } catch {
                    print(error.localizedDescription)
                }
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, .fetchFailed)
            }
        }
    }

    func fetchContributor(for repository: String, completion: @escaping ([Contributor]?, ApiError?) -> Void) {
        let provider = MoyaProvider<MyService>()
        provider.request(.fetchContributor(repository: repository)) { result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                if statusCode == 403 {
                    print("Rate limit error")
                    completion(nil, ApiError.rateLimit)
                    return
                }

                let data = moyaResponse.data
                do {
                    let contributors = try JSONDecoder().decode([Contributor].self, from: data)
                    completion(contributors, nil)
                } catch {
                    print(error.localizedDescription)
                }
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, .fetchFailed)
            }
        }
    }
}
