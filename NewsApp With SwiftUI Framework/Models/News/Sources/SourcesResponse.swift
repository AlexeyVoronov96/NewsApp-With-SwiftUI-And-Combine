//
//  SourcesResponse.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 09.10.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

struct SourcesResponse: Codable {
    let status: String
    let sources: Sources
}
