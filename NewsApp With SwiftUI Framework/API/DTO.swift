//
//  DTO.swift
//  SwiftUI Demo
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

struct Sources: Codable {
    let status: String
    let sources: [Source]
}

struct Source: Codable, Hashable {
    let id: String
    let name: String
    let description: String?
    let url: String
    let category: String
    let language: String
    let country: String
}

struct Articles: Codable {
    let status: String
    let articles: [Article]
}

struct Article: Codable, Hashable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
}
