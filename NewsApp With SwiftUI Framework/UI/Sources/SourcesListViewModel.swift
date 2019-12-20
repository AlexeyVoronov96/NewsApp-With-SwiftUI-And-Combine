//
//  SourcesListViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class SourcesListViewModel: ObservableObject {
    private let apiProvider = APIProvider<ArticleEndpoint>()
    
    private var cancellable: Cancellable?
    
    @Published private(set) var sources: Sources = []
    
    deinit {
        cancellable?.cancel()
    }
    
    func getSources() {
        cancellable = apiProvider.getData(from: .getSources)
            .decode(type: SourcesResponse.self, decoder: Container.jsonDecoder)
            .map { $0.sources }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (sources) in
                self?.sources = sources
            })
    }
}
