//
//  TopHeadlinesView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TopHeadlinesView : View {
    let topHeadlines: Articles
    
    var body: some View {
        PageView(topHeadlines.map { TopHeadlineRow(article: $0) })
    }
}
