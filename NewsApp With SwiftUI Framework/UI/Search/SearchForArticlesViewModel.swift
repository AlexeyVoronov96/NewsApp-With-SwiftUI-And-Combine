//
//  SearchForArticlesViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class SearchForArticlesViewModel: BindableObject {
    private let apiProvider = APIProvider()
    
    var didChange = PassthroughSubject<SearchForArticlesViewModel, Never>()
    
    private(set) var articles: [Article] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    func searchForArticles(searchFilter: String) {
        if searchFilter.isEmpty {
            self.articles = []
            return
        }
        
        apiProvider.searchForArticles(search: searchFilter) { (articles, error) in
            guard let articlesList = articles?.articles else { return }
            self.articles = articlesList
        }
    }
}
