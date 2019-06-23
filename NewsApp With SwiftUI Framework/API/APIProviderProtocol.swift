//
//  APIProviderProtocol.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 22.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation
import Combine

protocol APIProviderProtocol {
    func getSources() -> AnyPublisher<SourcesResponse, Error>
    
    func getArticlesFromSource(with source: String) -> AnyPublisher<ArticlesResponse, Error>
    
    func searchForArticles(search value: String) -> AnyPublisher<ArticlesResponse, Error>
    
    func getTopHeadlines() -> AnyPublisher<ArticlesResponse, Error>
    
    func getArticlesFromCategory(_ category: String) -> AnyPublisher<ArticlesResponse, Error>
}
