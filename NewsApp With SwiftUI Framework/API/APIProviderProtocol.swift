//
//  APIProviderProtocol.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 22.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

protocol APIProviderProtocol {
    func getSources() -> URLSession.DataTaskPublisher
    
    func getArticlesFromSource(with source: String) -> URLSession.DataTaskPublisher
    
    func searchForArticles(search value: String) -> URLSession.DataTaskPublisher
    
    func getTopHeadlines() -> URLSession.DataTaskPublisher
    
    func getArticlesFromCategory(_ category: String) -> URLSession.DataTaskPublisher
}
