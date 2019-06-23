//
//  SearchForArticlesView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct SearchForArticlesView : View {
    @ObjectBinding var viewModel = SearchForArticlesViewModel()
    
    @State private var searchFilter: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField($searchFilter,
                    placeholder: Text("Search articles...".localized()),
                    onEditingChanged: { (opened) in
                        if !opened {
                            self.viewModel.searchForArticles(searchFilter: self.searchFilter)
                        }
                })
                .frame(height: 40)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .border(Color.gray.opacity(0.2), cornerRadius: 8)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                ArticlesList(articles: self.viewModel.articles)
            }
            .navigationBarTitle(Text("Search".localized()), displayMode: .large)
        }
    }
}
