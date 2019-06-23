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
    private var locale: String {
        return Locale.current.languageCode ?? "en"
    }
    
    private var region: String {
        return Locale.current.regionCode ?? "us"
    }
    
    private var headers: [String: String] {
        return [
            "X-Api-Key": "6a4297c36e284e0bb57d89b044645c2e",
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    private let baseUrl: String = "https://newsapi.org/v2"
    
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    // MARK: - Requests
    func getSources() -> AnyPublisher<Sources, Error> {
        let params: [String: String] = [
            "language": locale
        ]
        
        let query = createQuery(with: params)
        
        let url = URL(string: baseUrl + Paths.sources.rawValue + query)!
        
        let request = performRequest(with: url)
        
        return getData(with: request, dataType: Sources.self)
    }
    
    func getArticlesFromSource(with source: String) -> AnyPublisher<Articles, Error> {
        let params: [String: String] = [
            "sources": source,
            "language": locale
        ]
        
        let query = createQuery(with: params)
        
        let url = URL(string: baseUrl + Paths.articles.rawValue + query)!
        
        let request = performRequest(with: url)
        
        return getData(with: request, dataType: Articles.self)
    }
    
    func searchForArticles(search value: String) -> AnyPublisher<Articles, Error> {
        let params: [String: String] = [
            "q": value,
            "language": self.locale
        ]
        
        let query = self.createQuery(with: params)
        
        let url = URL(string: self.baseUrl + Paths.articles.rawValue + query)!
        
        let request = performRequest(with: url)
        
        return getData(with: request, dataType: Articles.self)
    }
    
    func getTopHeadlines() -> AnyPublisher<Articles, Error> {
        let params: [String: String] = [
            "country": self.region
        ]
        
        let query = self.createQuery(with: params)
        
        let url = URL(string: self.baseUrl + Paths.topHeadlines.rawValue + query)!
        
        let request = performRequest(with: url)
        
        return getData(with: request, dataType: Articles.self)
    }
    
    func getArticlesFromCategory(_ category: String) -> AnyPublisher<Articles, Error> {
        let params: [String: String] = [
            "country": self.region,
            "category": category
        ]
        
        let query = self.createQuery(with: params)
        
        let url = URL(string: self.baseUrl + Paths.topHeadlines.rawValue + query)!
        
        let request = performRequest(with: url)
        
        return getData(with: request, dataType: Articles.self)
    }
    
    // MARK: - Request building
    private func createQuery(with params: [String: String]) -> String {
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        return "?\(queryParameters)"
    }
    
    private func performRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        
        for header in self.headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
    
    // MARK: - Getting data
    private func getData<T: Decodable>(with request: URLRequest, dataType: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ (error) -> Error in
                APIErrors(rawValue: error.code.rawValue) ?? APIProviderErrors.unknownError
            })
            .map { $0.data }
            .decode(type: dataType, decoder: jsonDecoder)
            .mapError { _ in APIProviderErrors.decodingError }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
