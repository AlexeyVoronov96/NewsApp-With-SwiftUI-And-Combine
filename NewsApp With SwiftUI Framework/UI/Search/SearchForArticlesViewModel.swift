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
        guard let request = apiProvider.performSearchForArticlesRequest(search: searchFilter),
            !searchFilter.isEmpty else {
            return articles = []
        }
        
        _ = apiProvider.getData(with: request)
            .map { $0.data }
            .decode(type: Articles.self, decoder: JSONDecoder())
            .map { $0.articles }
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (articles) in
                self?.articles = articles
            })
            .receive(completion: Subscribers.Completion<Never>.finished)
    }
}
