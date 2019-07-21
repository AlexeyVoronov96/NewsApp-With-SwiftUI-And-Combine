//
//  Weather.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 21.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let currently: CurrentWeather
    let hourly: HourlyWeatherData
    let daily: DailyWeatherData
}

struct CurrentWeather: Codable {
    let time: Date
    let icon: WeatherIcon
    let temperature: Double
}

struct HourlyWeatherData: Codable {
    let summary: String
    let data: [HourlyWeather]
}

struct HourlyWeather: Codable, Hashable {
    let time: Date
    let icon: WeatherIcon
    let temperature: Double
}

struct DailyWeatherData: Codable {
    let data: [DailyWeather]
}

struct DailyWeather: Codable, Hashable {
    let time: Date
    let icon: WeatherIcon
    let temperatureHigh: Double
    let temperatureLow: Double
}

extension CurrentWeather {
    var convertTemperature: String {
        return "\(Int(5 / 9 * (temperature - 32)))˚C"
    }
}

extension HourlyWeather {
    var convertTemperature: String {
            return "\(Int(5 / 9 * (temperature - 32)))˚C"
        }
}

extension DailyWeather {
    var averageTemperature: String {
        return "\(Int(5 / 9 * (((temperatureHigh + temperatureLow) / 2 ) - 32)))˚C"
    }
}

enum WeatherIcon: String, Codable {
    case clearDay = "clear-day"
    case clearNight
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
