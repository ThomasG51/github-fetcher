//
//  RepositoryViewModel.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import Foundation
import Moya

class RepositoryViewModel {
    func fetchRepository(by name: String, completion: @escaping (Repositories?, ApiError?) -> Void) {
        let provider = MoyaProvider<MyService>()
        provider.request(.fetchRepository(name: name)) { result in
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
                    let repositories = try JSONDecoder().decode(Repositories.self, from: data)
                    completion(repositories, nil)
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
