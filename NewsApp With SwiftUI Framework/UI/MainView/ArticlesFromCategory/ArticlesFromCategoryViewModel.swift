//
//  ArticlesFromCategoryViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class ArticlesFromCategoryViewModel: BindableObject {
    private let apiProvider: APIProviderProtocol
    
    private(set) var articles: [Article] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<ArticlesFromCategoryViewModel, Never>()
    
    init(apiProvider: APIProviderProtocol = APIProvider()) {
        self.apiProvider = apiProvider
    }
    
    func getArticles(from category: String) {
        apiProvider.getArticlesFromCategory(category)
            .map { $0.articles }
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (articles) in
                self?.articles = articles
            })
            .receive(completion: Subscribers.Completion<Never>.finished)
    }
}

