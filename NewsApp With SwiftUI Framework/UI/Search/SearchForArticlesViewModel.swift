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
    private let apiProvider: APIProviderProtocol
    
    private(set) var articles: Articles = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<SearchForArticlesViewModel, Never>()
    
    init(apiProvider: APIProviderProtocol = APIProvider()) {
        self.apiProvider = apiProvider
    }
    
    func searchForArticles(searchFilter: String) {
        apiProvider.searchForArticles(search: searchFilter)
            .map { $0.articles }
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (articles) in
                self?.articles = articles
            })
            .receive(completion: Subscribers.Completion<Never>.finished)
    }
}
