//
//  NewsList.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import SafariServices

struct NewsList : View {
    @State private var articles: [Article] = []
    
    var source: String
    
    private let apiProvider = APIProvider()
    
    var body: some View {
        List {
            ForEach(self.articles.identified(by: \.self)) { article in
                PresentationButton(destination: ArticleView(article: article)) {
                    ArticleRow(article: article)
                }
            }
        }
        .onAppear {
            self.getArticles()
        }
    }
    
    func getArticles() {
        apiProvider.getArticles(with: source) { (articles, error) in
            guard let articlesList = articles?.articles else { return }
            
            self.articles = articlesList
        }
    }
}
