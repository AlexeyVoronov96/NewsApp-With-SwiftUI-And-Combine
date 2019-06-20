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
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
        }
    }
    
    func getSources() {
        _ = apiProvider.getDataDemo(with: apiProvider.performSourcesRequest())
            .decode(type: Sources.self, decoder: JSONDecoder())
            .map { $0.sources }
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (sources) in
                self?.sources = sources
            })
    }
}
