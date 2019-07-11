//
//  APIProvider.swift
//  SwiftUI Demo
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation
import Combine

class APIProvider: APIProviderProtocol {
    private let baseUrl: String = "https://newsapi.org/v2"
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    private var headers: [String: String] {
        return [
            /// API key url: https://newsapi.org
            "X-Api-Key": "YOUR_API_KEY",
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    // MARK: - Request building
    func performRequest<T: Decodable>(_ request: Requests, type: T.Type) -> AnyPublisher<T, Error> {
        guard var urlComponents = URLComponents(string: baseUrl + request.path) else {
            return Publishers.Fail(error: APIProviderErrors.invalidURL)
                .eraseToAnyPublisher()
        }
        
        urlComponents.queryItems = request.params.compactMap({ (param) -> URLQueryItem in
            return URLQueryItem(name: param.key, value: param.value)
        })
        
        guard let url = urlComponents.url else {
            return Publishers.Fail(error: APIProviderErrors.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 30)
        
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return getData(with: request)
            .decode(type: type, decoder: jsonDecoder)
            .mapError { _ in APIProviderErrors.decodingError }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Getting data
    private func getData(with request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ (error) -> Error in
                APIErrors(rawValue: error.code.rawValue) ?? APIProviderErrors.unknownError
            })
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
