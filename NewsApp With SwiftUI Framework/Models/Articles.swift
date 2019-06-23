//
//  Articles.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 23.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

typealias Articles = [Article]

struct ArticlesResponse: Codable {
    let status: String
    let articles: Articles
}

struct Article: Codable, Hashable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
}
