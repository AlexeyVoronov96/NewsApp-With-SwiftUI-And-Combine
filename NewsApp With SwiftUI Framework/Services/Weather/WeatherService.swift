//
//  WeatherService.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 21.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class WeatherService: WeatherServiceProtocol {
    private let apiProvider = APIProvider<WeatherEndpoint>()

    private let locationManager = CLLocationManager()
    
    private var location: CLLocation? {
        return locationManager.location
    }
    
    func requestCurrentWeather() -> AnyPublisher<Data, Error> {
        locationManager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled() else {
            return Fail(error: WeatherServiceErrors.userDeniedWhenInUseAuthorization)
                .eraseToAnyPublisher()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        guard let location = location else {
            return Fail(error: WeatherServiceErrors.locationNil)
                .eraseToAnyPublisher()
        }
        
        return apiProvider.getData(from: .getCurrentWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            .map { [weak self] (data) -> Data in
                self?.locationManager.stopUpdatingLocation()
                return data
            }
            .eraseToAnyPublisher()
    }
}
