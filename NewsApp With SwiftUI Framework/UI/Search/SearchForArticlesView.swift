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
    
    @State private var searchFilter: String = ""
    
    var body: some View {
        NavigationView(content: {
            VStack {
                searchBar
                    .padding([.leading, .trailing], 8)
                    .frame(height: 32)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding([.leading, .trailing], 16)
            
                ArticlesList(articles: viewModel.articles)
            }
            .navigationBarTitle(Text("Search".localized()), displayMode: .large)
        })
    }
    
    private var searchBar: some View {
        TextField("Search articles...".localized(),
                  text: $searchFilter,
                  onEditingChanged: { (isOpened) in
                    if !isOpened {
                        self.viewModel.searchForArticles(searchFilter: self.searchFilter)
                    }
                }
        )
    }
}
