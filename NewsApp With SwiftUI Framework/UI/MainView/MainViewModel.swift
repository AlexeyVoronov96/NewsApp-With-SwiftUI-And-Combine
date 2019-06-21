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
    private let apiProvider = APIProvider()
    
    var didChange = PassthroughSubject<MainViewModel, Never>()
    
    private(set) var topHeadlines: [Article] = [] {
        didSet {
            self.didChange.send(self)
        }
    }
    
    func getTopHeadlines() {
        guard let request = apiProvider.performTopHeadlinesRequest() else {
            return topHeadlines = []
        }
        
        apiProvider.getData(with: request)
            .map { $0.data }
            .decode(type: Articles.self, decoder: JSONDecoder())
            .map { $0.articles }
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (articles) in
                self?.topHeadlines = articles
            })
            .receive(completion: Subscribers.Completion<Never>.finished)
    }
}
