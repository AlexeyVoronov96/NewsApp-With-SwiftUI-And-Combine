//
//  SearchForArticlesViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class SearchForArticlesViewModel: ObservableObject {
    private let apiProvider = APIProvider<ArticleEndpoint>()
    
    private var bag = Set<AnyCancellable>()
    
    @Published var searchText: String = "" {
        didSet {
            searchForArticles(searchFilter: searchText)
        }
    }
    @Published private (set) var articles: Articles = []
    
    func searchForArticles(searchFilter: String) {
        apiProvider.getData(from: .searchForArticles(searchFilter: searchFilter))
            .decode(type: ArticlesResponse.self, decoder: Container.jsonDecoder)
            .map { $0.articles }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] articles in
                self?.articles = articles
            })
            .store(in: &bag)
    }
}
