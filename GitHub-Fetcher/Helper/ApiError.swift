//
//  ApiError.swift
//  GitHub-Fetcher
//
//  Created by Thomas George on 27/05/2022.
//

import Foundation

enum ApiError: Error {
    case rateLimit
    case fetchFailed
}
