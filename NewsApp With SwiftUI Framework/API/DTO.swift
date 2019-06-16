//
//  DTO.swift
//  SwiftUI Demo
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

struct Sources: Codable, Hashable {
    let status: String
    let sources: [Source]
}

struct Source: Codable, Hashable {
    let id: String
    let name: String
    let description: String?
    let url: URL
    let category: String
    let language: String
    let country: String
}

struct Articles: Codable, Hashable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Hashable {
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: URL?
}
