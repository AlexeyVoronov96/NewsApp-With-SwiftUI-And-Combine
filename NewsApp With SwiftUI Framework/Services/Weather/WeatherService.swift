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

typealias LocationNameResultType = Result<String, Error>

class WeatherService: WeatherServiceProtocol {
    
    private let apiProvider = APIProvider<WeatherEndpoint>()

    private let locationManager = CLLocationManager()
    
    private lazy var location: CLLocation? = locationManager.location
    
    init() {
        startUpdatingLocation()
    }
    
    func getCityName(completion: @escaping (LocationNameResultType) -> Void) {
        guard let location = location else {
            completion(.failure(WeatherServiceErrors.locationNil))
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let placemark = placemarks?.first,
                let cityName = placemark.locality else {
                completion(.failure(WeatherServiceErrors.placeMarkNil))
                return
            }
            
            completion(.success(cityName))
        }
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
        
        return apiProvider.getData(
            from: .getCurrentWeather(latitude: location.coordinate.latitude,
                                     longitude: location.coordinate.longitude)
        )
            .eraseToAnyPublisher()
    }
    
    deinit {
        stopUpdatingLocation()
    }
}

private extension WeatherService {
    func startUpdatingLocation() {
        locationManager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}
