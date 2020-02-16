//
//  SearchForArticlesView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct SearchForArticlesView : View {
    @ObservedObject var viewModel = SearchForArticlesViewModel()
    
    var body: some View {
        NavigationView(content: {
            VStack {
                SearchBarView(text: $viewModel.searchText)
                    .padding([.leading, .trailing], 8)
                
                ArticlesList(articles: viewModel.articles)
            }
            .navigationBarTitle(Text(Constants.title), displayMode: .large)
        })
    }
}

private extension SearchForArticlesView {
    
    struct Constants {
        static let title = "Search".localized()
    }
}

