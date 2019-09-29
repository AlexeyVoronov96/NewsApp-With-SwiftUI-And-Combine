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
    static let shared: WeatherServiceProtocol = WeatherService()
    
    private let apiProvider: APIProviderProtocol = APIProvider.shared

    private let locationManager = CLLocationManager()
    
    private var location: CLLocation? {
        return self.locationManager.location
    }
    
    func requestCurrentWeather() -> AnyPublisher<Data, Error> {
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            guard let location = self.location else {
                return Fail(error: WeatherServiceErrors.locationNil)
                    .eraseToAnyPublisher()
            }
            
            return apiProvider.getData(from: .getCurrentWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                .map { (data) -> Data in
                    self.locationManager.stopUpdatingLocation()
                    return data
                }
                .eraseToAnyPublisher()
        }
        
        return Fail(error: WeatherServiceErrors.userDeniedWhenInUseAuthorization)
            .eraseToAnyPublisher()
    }
}
