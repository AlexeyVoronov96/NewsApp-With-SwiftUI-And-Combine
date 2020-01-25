//
//  ArticlesFromCategoryView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticlesFromCategoryView : View {
    @ObservedObject var viewModel = ArticlesFromCategoryViewModel()
    
    let category: String
    
    var body: some View {
        VStack {
            if viewModel.articles.isEmpty {
                ActivityIndicator()
                    .frame(width: UIScreen.main.bounds.width,
                           height: 50,
                           alignment: .center)
            } else {
                ArticlesList(articles: viewModel.articles)
            }
        }
        .onAppear {
            self.viewModel.getArticles(from: self.category)
        }
    }
}
