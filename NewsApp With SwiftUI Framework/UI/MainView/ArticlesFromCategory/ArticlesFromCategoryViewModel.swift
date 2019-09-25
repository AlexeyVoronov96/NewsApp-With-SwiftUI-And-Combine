//
//  ArticlesFromCategoryViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class ArticlesFromCategoryViewModel: ObservableObject {
    private let apiProvider: APIProviderProtocol = APIProvider.shared
    
    private var cancellable: Cancellable?
    
    @Published private(set) var articles: Articles = []
    
    deinit {
        cancellable?.cancel()
    }
    
    func getArticles(from category: String) {
        cancellable = apiProvider.performRequest(.getArticlesFromCategory(category))
            .decode(type: ArticlesResponse.self, decoder: Container.jsonDecoder)
            .map { $0.articles }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (articles) in
                self?.articles = articles
            })
    }
}

