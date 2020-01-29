//
//  DailyWeather.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 09.10.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

struct DailyWeather: Codable, Hashable {
    let time: Date
    let icon: WeatherIcon
    let temperatureHigh: Double
    let temperatureLow: Double
}

extension DailyWeather {
    var averageTemperature: String {
        return "\(Int(5 / 9 * (((temperatureHigh + temperatureLow) / 2 ) - 32)))˚C"
    }
}
