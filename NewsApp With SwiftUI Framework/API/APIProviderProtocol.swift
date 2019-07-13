//
//  APIProviderProtocol.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 22.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Combine

protocol APIProviderProtocol {
    func performRequest<T: Decodable>(_ request: Requests, type: T.Type) -> AnyPublisher<T, Error>
}
