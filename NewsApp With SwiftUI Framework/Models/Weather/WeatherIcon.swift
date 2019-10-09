//
//  WeatherIcon.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 09.10.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum WeatherIcon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain
    case snow
    case sleet
    case wind
    case fog
    case cloudy
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    
    var systemImage: String {
        switch self {
        case .clearDay:
            return "sun.max.fill"
        
        case .clearNight:
            return "moon.fill"
        
        case .rain:
            return "cloud.rain.fill"
        
        case .snow:
            return "cloud.snow.fill"
        
        case .sleet:
            return "cloud.sleet.fill"
            
        case .wind:
            return "wind"
        
        case .fog:
            return "cloud.fog.fill"
        
        case .cloudy:
            return "cloud.fill"
        
        case .partlyCloudyDay:
            return "cloud.sun.fill"
        
        case .partlyCloudyNight:
            return "cloud.moon.fill"
        }
    }
}
