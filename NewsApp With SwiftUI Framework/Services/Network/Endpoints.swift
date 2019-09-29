//
//  Endpoints.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 23.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum Endpoints {
    case getTopHeadlines
    case getArticlesFromCategory(_ category: String)
    case getSources
    case getArticlesFromSource(_ source: String)
    case searchForArticles(searchFilter: String)
    case getCurrentWeather(latitude: Double, longitude: Double)
    
    private var locale: String {
        return Locale.current.languageCode ?? "en"
    }
    
    private var region: String {
        return Locale.current.regionCode ?? "us"
    }
    
    private var baseURL: String {
        switch self {
        case .getCurrentWeather:
            return "https://api.darksky.net"
        default:
            return "https://newsapi.org/v2"
        }
    }
    
    var absoluteURL: String {
        switch self {
        case .getTopHeadlines, .getArticlesFromCategory:
            return baseURL + "/top-headlines"
            
        case .getSources:
            return baseURL + "/sources"
            
        case .getArticlesFromSource, .searchForArticles:
            return baseURL + "/everything"
            
        case let .getCurrentWeather(latitude, longitude):
            return baseURL + "/forecast/\(Container.weatherAPIKey)/\(latitude),\(longitude)"
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

        case .getCurrentWeather:
            return ["lang": locale]
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .getCurrentWeather:
            return [
                "Content-type": "application/json",
                "Accept": "application/json"
            ]
            
        default:
            return [
                "X-Api-Key": Container.newsAPIKey,
                "Content-type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
}
