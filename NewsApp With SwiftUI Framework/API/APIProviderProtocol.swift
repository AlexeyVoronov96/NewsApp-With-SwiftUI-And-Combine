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
    func getSources() -> AnyPublisher<Sources, Error>
    
    func getArticlesFromSource(with source: String) -> AnyPublisher<Articles, Error>
    
    func searchForArticles(search value: String) -> AnyPublisher<Articles, Error>
    
    func getTopHeadlines() -> AnyPublisher<Articles, Error>
    
    func getArticlesFromCategory(_ category: String) -> AnyPublisher<Articles, Error>
}
