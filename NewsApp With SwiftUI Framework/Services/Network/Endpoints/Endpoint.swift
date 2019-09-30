//
//  Endpoint.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 30.09.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    
    var absoluteURL: String { get }
    
    var params: [String: String] { get }
    
    var headers: [String: String] { get }
}
