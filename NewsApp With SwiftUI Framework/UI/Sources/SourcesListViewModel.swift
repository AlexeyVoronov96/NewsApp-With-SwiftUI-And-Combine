//
//  SourcesListViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class SourcesListViewModel: BindableObject {
    private let apiProvider = APIProvider()
    
    var didChange = PassthroughSubject<SourcesListViewModel, Never>()
    
    private(set) var sources: [Source] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    func getSources() {
        guard let request = apiProvider.performSourcesRequest() else {
            return sources = []
        }
        
        apiProvider.getData(with: request)
            .map { $0.data }
            .decode(type: Sources.self, decoder: JSONDecoder())
            .map { $0.sources }
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (sources) in
                self?.sources = sources
            })
            .receive(completion: Subscribers.Completion<Never>.finished)
    }
}
