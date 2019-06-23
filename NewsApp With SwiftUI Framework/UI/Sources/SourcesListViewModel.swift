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
    private let apiProvider: APIProviderProtocol
    
    private(set) var sources: [Source] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<SourcesListViewModel, Never>()
    
    init(apiProvider: APIProviderProtocol = APIProvider()) {
        self.apiProvider = apiProvider
    }
    
    func getSources() {
        apiProvider.getSources()
            .map { $0.sources }
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (sources) in
                self?.sources = sources
            })
            .receive(completion: Subscribers.Completion<Never>.finished)
    }
}
