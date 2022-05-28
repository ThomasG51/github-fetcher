//
//  RepositoryViewModel.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import Foundation
import Moya
import RealmSwift

class RepositoryViewModel {
    /**
     Load repositories data stored in Realm
     - Parameters:
        - completion: A completion block that returns an optional `Repositories`.
     */
    func loadRealmObject(completion: @escaping (Repositories?) -> Void) {
        do {
            let realm = try Realm()
            let realmObject = realm.objects(Repositories.self)
            completion(realmObject.first)
        } catch {
            print(error.localizedDescription)
        }
    }

    /**
     Fetch repositories data from GitHub API
     - Parameters:
        - name: Repository name.
        - completion: A completion block that returns an optional `Repositories` and an optional `ApiError`.
     */
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
                    let realm = try Realm()
                    try realm.write {
                        realm.create(Repositories.self, value: repositories, update: .modified)
                    }
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
