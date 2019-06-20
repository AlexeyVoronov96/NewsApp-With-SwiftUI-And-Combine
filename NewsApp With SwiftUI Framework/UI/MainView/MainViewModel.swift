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
            DispatchQueue.main.async { [unowned self] in
                self.didChange.send(self)
            }
        }
    }
    
    func getTopHeadlines() {
        guard let request = apiProvider.performTopHeadlinesRequest() else {
            return topHeadlines = []
        }
        
        _ = apiProvider.getData(with: request)
            .decode(type: Articles.self, decoder: JSONDecoder())
            .map { $0.articles }
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (articles) in
                self?.topHeadlines = articles
            })
    }
}
