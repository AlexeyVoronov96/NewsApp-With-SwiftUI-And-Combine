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
    private let locale: String
    private let region: String
    private let baseUrl: String
    private let jsonDecoder: JSONDecoder
    
    private var headers: [String: String] {
        return [
            "X-Api-Key": "6a4297c36e284e0bb57d89b044645c2e",
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    init() {
        self.locale = Locale.current.languageCode ?? "en"
        self.region = Locale.current.regionCode ?? "us"
        self.baseUrl = "https://newsapi.org/v2"
        self.jsonDecoder = JSONDecoder()
    }
    
    // MARK: - Requests
    func getSources() -> AnyPublisher<SourcesResponse, Error> {
        let params: [String: String] = [
            "language": locale
        ]
        
        let request = performRequest(with: .sources, params: params)
        
        return getData(with: request, type: SourcesResponse.self)
    }
    
    func getArticlesFromSource(with source: String) -> AnyPublisher<ArticlesResponse, Error> {
        let params: [String: String] = [
            "sources": source,
            "language": locale
        ]
        
        let request = performRequest(with: .articles, params: params)
        
        return getData(with: request, type: ArticlesResponse.self)
    }
    
    func searchForArticles(search value: String) -> AnyPublisher<ArticlesResponse, Error> {
        let params: [String: String] = [
            "q": value,
            "language": self.locale
        ]
        
        let request = performRequest(with: .articles, params: params)
        
        return getData(with: request, type: ArticlesResponse.self)
    }
    
    func getTopHeadlines() -> AnyPublisher<ArticlesResponse, Error> {
        let params: [String: String] = [
            "country": self.region
        ]
        
        let request = performRequest(with: .topHeadlines, params: params)
        
        return getData(with: request, type: ArticlesResponse.self)
    }
    
    func getArticlesFromCategory(_ category: String) -> AnyPublisher<ArticlesResponse, Error> {
        let params: [String: String] = [
            "country": self.region,
            "category": category
        ]
        
        let request = performRequest(with: .topHeadlines, params: params)
        
        return getData(with: request, type: ArticlesResponse.self)
    }
    
    // MARK: - Request building
    private func createQuery(with params: [String: String]) -> String {
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        return "?\(queryParameters)"
    }
    
    private func performRequest(with path: Paths, params: [String: String]) -> URLRequest {
        let query = createQuery(with: params)
        
        let url = URL(string: baseUrl + path.rawValue + query)!
        
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        
        for header in self.headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
    
    // MARK: - Getting data
    private func getData<T: Decodable>(with request: URLRequest, type: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ (error) -> Error in
                APIErrors(rawValue: error.code.rawValue) ?? APIProviderErrors.unknownError
            })
            .map { $0.data }
            .decode(type: type, decoder: jsonDecoder)
            .mapError { _ in APIProviderErrors.decodingError }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
