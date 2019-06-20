//
//  NewsList.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticlesFromSourceView: View {
    @ObjectBinding var viewModel = ArticlesFromSourceViewModel()
    
    var source: String
    
    var body: some View {
        ArticlesList(articles: viewModel.articles)
        .onAppear {
            self.viewModel.getArticles(from: self.source)
        }
    }
}
