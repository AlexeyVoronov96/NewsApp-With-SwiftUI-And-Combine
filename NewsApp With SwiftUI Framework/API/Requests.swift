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
    
    var path: String {
        switch self {
        case .getTopHeadlines, .getArticlesFromCategory:
            return "/top-headlines"
            
        case .getSources:
            return "/sources"
            
        case .getArticlesFromSource, .searchForArticles:
            return "/everything"
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
}
