//
//  SearchForSourcesList.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct SearchForSourcesList : View {
    @State private var articles: [Article] = []
    @State private var text: String = ""
    
    private let apiProvider = APIProvider()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField($text,
                          placeholder: Text("Search sources..."),
                          onCommit: { self.searchForSources() })
                    .frame(height: 40)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    .border(Color.gray.opacity(0.2), cornerRadius: 8)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                List {
                    ForEach(self.articles.identified(by: \.self)) { article in
                        ArticleRow(article: article)
                    }
                }
            }
            .navigationBarTitle(Text("Search"), displayMode: .large)
        }
    }
    
    private func searchForSources() {
        if text.isEmpty {
            self.articles = []
            return
        }
        apiProvider.searchForArticles(search: self.text) { (articles, error) in
            guard let articlesList = articles?.articles else { return }
            self.articles = articlesList
        }
    }
}
