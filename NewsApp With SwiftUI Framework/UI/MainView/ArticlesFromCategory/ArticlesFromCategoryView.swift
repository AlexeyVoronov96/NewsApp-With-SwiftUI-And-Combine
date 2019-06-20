//
//  ArticlesFromCategoryView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticlesFromCategoryView : View {
    @ObjectBinding var viewModel = ArticlesFromCategoryViewModel()
    
    var category: String = ""
    
    var body: some View {
        ArticlesList(articles: viewModel.articles)
        .onAppear {
            self.viewModel.getArticles(from: self.category)
        }
    }
}
