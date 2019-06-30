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
    private let apiProvider: APIProviderProtocol
    
    private(set) var topHeadlines: Articles = [] {
        didSet {
            self.didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<MainViewModel, Never>()
    
    init() {
        self.apiProvider = APIProvider()
    }
    
    func clearTopHeadlines() {
        self.topHeadlines = []
    }
    
    func getTopHeadlines() {
        apiProvider.getTopHeadlines()
            .map { $0.articles }
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (articles) in
                self?.topHeadlines = articles
            })
            .receive(completion: Subscribers.Completion<Never>.finished)
    }
}
