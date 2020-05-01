//
//  WeatherViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 21.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class WeatherViewModel: ObservableObject {
    private let weatherService: WeatherServiceProtocol = WeatherService()
    
    private var bag = Set<AnyCancellable>()
    
    @Published private (set) var weather: WeatherResponse?
    @Published private (set) var locationName: String = Constants.gettingYourLocationText
    
    func getCityName() {
        weatherService.getCityName { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(locationName):
                self.locationName = locationName
            case .failure:
                self.locationName = Constants.gettingLocationErrorText
            }
        }
    }
    
    func getCurrentWeather() {
        weatherService.requestCurrentWeather()
            .decode(type: WeatherResponse.self, decoder: Container.weatherJSONDecoder)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.weather = nil
                },
                receiveValue: { [weak self] weather in
                    self?.weather = weather
                }
            )
            .store(in: &bag)
    }
}

private extension WeatherViewModel {
    
    struct Constants {
        static let gettingYourLocationText = "Getting your location".localized()
        static let gettingLocationErrorText = "Can't get your location name".localized()
    }
}
