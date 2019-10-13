//
//  Weather.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 21.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

struct Weather: Codable, Hashable {
    let time: Date
    let icon: WeatherIcon
    let temperature: Double
}

extension Weather {
    var convertTemperature: String {
        return "\(Int(5 / 9 * (temperature - 32)))˚C"
    }
}
