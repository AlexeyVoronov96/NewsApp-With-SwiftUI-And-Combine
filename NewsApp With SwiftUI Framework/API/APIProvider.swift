//
//  APIProvider.swift
//  SwiftUI Demo
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class APIProvider {
    static let shared = APIProvider()
    
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
    func performSourcesRequest() -> URLRequest? {
        let params: [String: String] = [
            "language": locale
        ]
        
        let query = createQuery(with: params)
        
        guard let url = URL(string: baseUrl + Paths.sources.rawValue + query) else {
            return nil
        }
        
        return performRequest(with: url)
    }
    
    func performArticlesFromSourceRequest(with source: String) -> URLRequest? {
        let params: [String: String] = [
            "sources": source,
            "language": locale
        ]
        
        let query = createQuery(with: params)
        
        guard let url = URL(string: baseUrl + Paths.articles.rawValue + query) else {
            return nil
        }
        
        return performRequest(with: url)
    }
    
    func performSearchForArticlesRequest(search value: String, page: Int = 1) -> URLRequest? {
        let params: [String: String] = [
            "q": value,
            "language": self.locale
        ]
        
        let query = self.createQuery(with: params)
        
        guard let url = URL(string: self.baseUrl + Paths.articles.rawValue + query) else {
            return nil
        }
        
        return performRequest(with: url)
    }
    
    func performTopHeadlinesRequest() -> URLRequest? {
        let params: [String: String] = [
            "country": self.region
        ]
        
        let query = self.createQuery(with: params)
        
        guard let url = URL(string: self.baseUrl + Paths.topHeadlines.rawValue + query) else {
            return nil
        }
        
        return performRequest(with: url)
    }
    
    func performArticlesFromCategoryRequest(_ category: String) -> URLRequest? {
        let params: [String: String] = [
            "country": self.region,
            "category": category
        ]
        
        let query = self.createQuery(with: params)
        
        guard let url = URL(string: self.baseUrl + Paths.topHeadlines.rawValue + query) else {
            return nil
        }
        
        return performRequest(with: url)
    }
    
    // MARK: - Request building
    private func createQuery(with params: [String: String]) -> String {
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        return "?\(queryParameters)"
    }
    
    func performRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        
        for header in self.headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
    
    func getData(with request: URLRequest) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: request)
    }
}
