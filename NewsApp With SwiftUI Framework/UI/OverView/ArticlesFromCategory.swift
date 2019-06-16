//
//  ArticlesFromCategory.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticlesFromCategory : View {
    var category: String = ""
    
    @State private var articles: [Article] = []
    
    private let apiProvider = APIProvider()
    
    var body: some View {
        List {
            ForEach(self.articles.identified(by: \.self)) { article in
                PresentationButton(ArticleRow(article: article), destination: ArticleView(article: article))
                }
            }
            .onAppear {
                self.getArticles()
        }
    }
    
    private func getArticles() {
        apiProvider.getArticleFromCategory(self.category) { (articles, error) in
            guard let articlesList = articles?.articles else { return }
            
            self.articles = articlesList
        }
    }
}

#if DEBUG
struct ArticlesFromCategory_Previews : PreviewProvider {
    static var previews: some View {
        ArticlesFromCategory()
    }
}
#endif
