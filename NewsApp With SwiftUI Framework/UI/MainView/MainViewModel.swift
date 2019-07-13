//
//  MainViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class MainViewModel: BindableObject {
    private let apiProvider: APIProviderProtocol = APIProvider.shared
    
    private(set) var topHeadlines: Articles = [] {
        didSet {
            self.didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<MainViewModel, Never>()
    
    func clearTopHeadlines() {
        self.topHeadlines = []
    }
    
    func getTopHeadlines() {
        apiProvider.performRequest(.getTopHeadlines)
            .decode(type: ArticlesResponse.self, decoder: Container.jsonDecoder)
            .map { $0.articles }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (articles) in
                self?.topHeadlines = articles
            })
            .receive(completion: Subscribers.Completion<Never>.finished)
    }
}
