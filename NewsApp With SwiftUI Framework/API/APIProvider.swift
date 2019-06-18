//
//  APIProvider.swift
//  SwiftUI Demo
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

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
    
    private let jsonDecoder = JSONDecoder()
    
    // MARK: - Requests
    func getSources(completion: @escaping ((Sources?, Error?) -> Void)) {
        let params: [String: String] = [
            "language": self.locale
        ]
        
        let query = self.createQuery(with: params)
        
        guard let  url = URL(string: self.baseUrl + Paths.sources.rawValue + query) else {
            completion(nil, APIProviderErrors.invalidURL)
            return
        }
        
        self.getData(url, with: Sources.self) { (data, error) in
            completion(data, error)
        }
    }
    
    func getArticles(with source: String, completion: @escaping ((Articles?, Error?) -> Void)) {
        let params: [String: String] = [
            "sources": source,
            "language": self.locale
        ]
        
        let query = self.createQuery(with: params)
        
        guard let url = URL(string: self.baseUrl + Paths.articles.rawValue + query) else {
            completion(nil, APIProviderErrors.invalidURL)
            return
        }
        
        self.getData(url, with: Articles.self) { (data, error) in
            completion(data, error)
        }
    }
    
    func searchForArticles(search value: String, page: Int = 1, completion: @escaping ((Articles?, Error?) -> Void)) {
        let params: [String: String] = [
            "q": value,
            "language": self.locale
        ]
        
        let query = self.createQuery(with: params)
        
        guard let url = URL(string: self.baseUrl + Paths.articles.rawValue + query) else {
            completion(nil, APIProviderErrors.invalidURL)
            return
        }
        
        self.getData(url, with: Articles.self) { (data, error) in
            completion(data, error)
        }
    }
    
    func getTopHeadlines(completion: @escaping ((Articles?, Error?) -> Void)) {
        let params: [String: String] = [
            "country": self.region
        ]
        
        let query = self.createQuery(with: params)
        
        guard let url = URL(string: self.baseUrl + Paths.topHeadlines.rawValue + query) else {
            completion(nil, APIProviderErrors.invalidURL)
            return
        }
        
        self.getData(url, with: Articles.self) { (data, error) in
            completion(data, error)
        }
    }
    
    func getArticlesFromCategory(_ category: String, completion: @escaping ((Articles?, Error?) -> Void)) {
        let params: [String: String] = [
            "country": self.region,
            "category": category
        ]
        
        let query = self.createQuery(with: params)
        
        guard let url = URL(string: self.baseUrl + Paths.topHeadlines.rawValue + query) else {
            completion(nil, APIProviderErrors.invalidURL)
            return
        }
        
        self.getData(url, with: Articles.self) { (data, error) in
            completion(data, error)
        }
    }
    
    // MARK: - Request building
    private func createQuery(with params: [String: String]) -> String {
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        return "?\(queryParameters)"
    }
    
    private func performRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        
        for header in self.headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
    
    // MARK: - Getting data
    private func getData<T: Decodable>(_ url: URL, with type: T.Type, completion: @escaping ((T?, Error?) -> Void)) {
        let urlRequest = self.performRequest(with: url)
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                guard let httpResponse = response as? HTTPURLResponse,
                    let apiError = APIErrors(rawValue: httpResponse.statusCode) else {
                        completion(nil, APIProviderErrors.unknownError)
                        return
                }
                
                completion(nil, apiError)
                return
            }
            
            guard let data = data else {
                completion(nil, APIProviderErrors.dataNil)
                return
            }
            
            guard let decodedData = self.parse(with: type, from: data) else {
                completion(nil, APIProviderErrors.decodingError)
                return
            }
            
            completion(decodedData, nil)
        }
        .resume()
    }
    
    // MARK: - Parsing data
    private func parse<T: Decodable>(with type: T.Type, from data: Data) -> T? {
        return try? self.jsonDecoder.decode(type, from: data)
    }
}
