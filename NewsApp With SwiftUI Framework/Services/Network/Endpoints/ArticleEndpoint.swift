//
//  ArticleEndpoint.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 23.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum ArticleEndpoint: EndpointProtocol {
    case getTopHeadlines
    case getArticlesFromCategory(_ category: String)
    case getSources
    case getArticlesFromSource(_ source: String)
    case searchForArticles(searchFilter: String)
    
    var baseURL: String {
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
            "X-Api-Key": Container.newsAPIKey,
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
}
