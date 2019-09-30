//
//  APIProviderProtocol.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 22.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Combine
import Foundation

protocol APIProviderProtocol {
    func getData(from endpoint: Endpoint) -> AnyPublisher<Data, Error>
}
