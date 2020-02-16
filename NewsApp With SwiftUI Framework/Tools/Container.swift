//
//  Container.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 13.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

class Container {
    static let jsonDecoder: JSONDecoder = JSONDecoder()
    
    static var weatherJSONDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return jsonDecoder
    }()
    
    /// News API key url: https://newsapi.org
    static let newsAPIKey: String = "2dd517ab40234c28ac65a27b4845a4aa"
    
    /// Weather API key url: https://darksky.net
    static let weatherAPIKey: String = "7aaa77c1ca5f9bb8a2db5169856d5af6"
}
