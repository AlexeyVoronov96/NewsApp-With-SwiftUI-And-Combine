//
//  Requests.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 23.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum Requests {
    case getTopHeadlines
    case getArticlesFromCategory(_ category: String)
    case getSources
    case getArticlesFromSource(_ source: String)
    case searchForArticles(searchFilter: String)
    
    private var locale: String {
        return Locale.current.languageCode ?? "en"
    }
    
    private var region: String {
        return Locale.current.regionCode ?? "us"
    }
    
    private var baseURL: String {
        return "https://newsapi.org/v2"
    }
    
    var absoluteURL: String {
        switch self {
        case .getTopHeadlines, .getArticlesFromCategory:
            return baseURL + "/top-headlines"
            
        case .getSources:
            return baseURL + "/sources"
            
        case .getArticlesFromSource, .searchForArticles:
            return baseURL + "/everything"
        }
    }
    
    var params: [String: String] {
        switch self {
        case .getTopHeadlines:
            return ["country": region]
            
        case let .getArticlesFromCategory(category):
            return ["country": region, "category": category]
            
        case .getSources:
            return ["language": locale, "country": region]
            
        case let .getArticlesFromSource(source):
            return ["sources": source, "language": locale]
            
        case let .searchForArticles(searchFilter):
            return ["q": searchFilter, "language": locale]
        }
    }
    
    var headers: [String: String] {
        return [
            /// API key url: https://newsapi.org
            "X-Api-Key": "YOUR_API_KEY",
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
}
