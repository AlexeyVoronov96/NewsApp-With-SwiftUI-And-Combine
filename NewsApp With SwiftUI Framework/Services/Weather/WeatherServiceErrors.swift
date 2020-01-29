//
//  WeatherServiceErrors.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 21.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum WeatherServiceErrors: LocalizedError {
    case userDeniedWhenInUseAuthorization
    case locationNil
    case placeMarkNil
    
    var errorDescription: String? {
        switch self {
        case .userDeniedWhenInUseAuthorization:
            return "You've denied location authorization".localized()
            
        case .locationNil:
            return "Something goes wrong.".localized()
            
        case .placeMarkNil:
            return "Can't get location name"
        }
    }
}
