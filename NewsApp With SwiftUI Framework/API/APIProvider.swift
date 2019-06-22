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
    enum Paths: String {
        case sources = "sources"
        case articles = "everything"
        case topHeadlines = "top-headlines"
    }
    
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
    
    private let baseUrl: String = "https://newsapi.org/v2/"
    
    // MARK: - Requests
    func getSources() -> URLSession.DataTaskPublisher {
        let params: [String: String] = [
            "language": locale
        ]
        
        let query = createQuery(with: params)
        
        let url = URL(string: baseUrl + Paths.sources.rawValue + query)!
        
        return performRequest(with: url)
    }
    
    func getArticlesFromSource(with source: String) -> URLSession.DataTaskPublisher {
        let params: [String: String] = [
            "sources": source,
            "language": locale
        ]
        
        let query = createQuery(with: params)
        
        let url = URL(string: baseUrl + Paths.articles.rawValue + query)!
        
        return performRequest(with: url)
    }
    
    func searchForArticles(search value: String) -> URLSession.DataTaskPublisher {
        let params: [String: String] = [
            "q": value,
            "language": self.locale
        ]
        
        let query = self.createQuery(with: params)
        
        let url = URL(string: self.baseUrl + Paths.articles.rawValue + query)!
        
        return performRequest(with: url)
    }
    
    func getTopHeadlines() -> URLSession.DataTaskPublisher {
        let params: [String: String] = [
            "country": self.region
        ]
        
        let query = self.createQuery(with: params)
        
        let url = URL(string: self.baseUrl + Paths.topHeadlines.rawValue + query)!
        
        return performRequest(with: url)
    }
    
    func getArticlesFromCategory(_ category: String) -> URLSession.DataTaskPublisher {
        let params: [String: String] = [
            "country": self.region,
            "category": category
        ]
        
        let query = self.createQuery(with: params)
        
        let url = URL(string: self.baseUrl + Paths.topHeadlines.rawValue + query)!
        
        return performRequest(with: url)
    }
    
    // MARK: - Request building
    private func createQuery(with params: [String: String]) -> String {
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        return "?\(queryParameters)"
    }
    
    private func performRequest(with url: URL) -> URLSession.DataTaskPublisher {
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        
        for header in self.headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return getData(with: request)
    }
    
    // MARK: - Getting data
    private func getData(with request: URLRequest) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: request)
    }
}
