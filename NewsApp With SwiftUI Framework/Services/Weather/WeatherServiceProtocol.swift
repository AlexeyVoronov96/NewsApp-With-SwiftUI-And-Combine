//
//  WeatherServiceProtocol.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 22.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Combine
import Foundation

protocol WeatherServiceProtocol {
    func getCityName(completion: @escaping (LocationNameResultType) -> Void)
    func requestCurrentWeather() -> AnyPublisher<Data, Error>
}
