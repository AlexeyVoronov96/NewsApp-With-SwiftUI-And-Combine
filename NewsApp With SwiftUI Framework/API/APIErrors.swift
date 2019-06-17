//
//  APIErrors.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 17.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum APIErrors: Int, LocalizedError {
    case badRequest = 400
    case unAuthorized = 401
    case tooManyRequests = 429
    case serverError = 500
    
    var errorDescription: String? {
        switch self {
        case .tooManyRequests:
            return "You made too many requests within a window of time and have been rate limited. Back off for a while.".localized()
        case .serverError:
            return "Server error.".localized()
        default:
            return "Something goes wrong.".localized()
        }
    }
}
