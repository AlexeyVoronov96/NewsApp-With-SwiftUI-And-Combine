//
//  APIProviderErrors.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 17.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum APIProviderErrors: LocalizedError {
    case invalidURL
    case dataNil
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .dataNil:
            return "Empty data.".localized()
        case .decodingError:
            return "Data has invalid format.".localized()
        default:
            return "Something goes wrong.".localized()
        }
    }
}
