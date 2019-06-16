//
//  APIProvider.swift
//  SwiftUI Demo
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

class APIProvider {
    var headers: [String: String] {
        return [
            "X-Api-Key": "6a4297c36e284e0bb57d89b044645c2e",
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    let baseUrl: String = "https://newsapi.org/v2/"
    
    private let jsonDecoder = JSONDecoder()
    
    private func performRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        
        for header in self.headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
    
    func getSources(completion: @escaping ((Sources?, Error?) -> Void)) {
        let params: [String: String] = [
            "language": "ru"
        ]
        
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        guard let  url = URL(string: self.baseUrl + "sources" + "?" + queryParameters) else {
            completion(nil, nil)
            return
        }
        
        self.getData(url, with: Sources.self) { (data, error) in
            completion(data, error)
        }
    }
    
    func getArticles(with source: String, completion: @escaping ((Articles?, Error?) -> Void)) {
        let params: [String: String] = [
            "sources": source,
            "language": "ru"
        ]
        
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        guard let url = URL(string: self.baseUrl + "everything" + "?" + queryParameters) else {
            completion(nil, nil)
            return
        }
        
        self.getData(url, with: Articles.self) { (data, error) in
            completion(data, error)
        }
    }
    
    func searchForArticles(search value: String, completion: @escaping ((Articles?, Error?) -> Void)) {
        let params: [String: String] = [
            "q": value,
            "language": "ru"
        ]
        
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        guard let url = URL(string: self.baseUrl + "everything" + "?" + queryParameters) else {
            completion(nil, nil)
            return
        }
        
        self.getData(url, with: Articles.self) { (data, error) in
            completion(data, error)
        }
    }
    
    func getTopHeadlines(completion: @escaping ((Articles?, Error?) -> Void)) {
        let params: [String: String] = [
            "country": "ru"
        ]
        
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        guard let url = URL(string: self.baseUrl + "top-headlines" + "?" + queryParameters) else {
            completion(nil, nil)
            return
        }
        
        self.getData(url, with: Articles.self) { (data, error) in
            completion(data, error)
        }
    }
    
    func getArticleFromCategory(_ category: String, completion: @escaping ((Articles?, Error?) -> Void)) {
        let params: [String: String] = [
            "country": "ru",
            "category": category
        ]
        
        let queryParameters = params.compactMap({ (parameter) -> String in
            return "\(parameter.key)=\(parameter.value)"
        }).joined(separator: "&")
        
        guard let url = URL(string: self.baseUrl + "top-headlines" + "?" + queryParameters) else {
            completion(nil, nil)
            return
        }
        
        self.getData(url, with: Articles.self) { (data, error) in
            completion(data, error)
        }
    }
    
    private func getData<T: Decodable>(_ url: URL, with type: T.Type, completion: @escaping ((T?, Error?) -> Void)) {
        let urlRequest = self.performRequest(with: url)
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { (data, _, error) in
            if error != nil {
                completion(nil, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            guard let decodedData = self.parse(with: type, from: data) else {
                completion(nil, nil)
                return
            }
            
            completion(decodedData, nil)
            }.resume()
    }
    
    private func parse<T: Decodable>(with type: T.Type, from data: Data) -> T? {
        return try? self.jsonDecoder.decode(type, from: data)
    }
}
