//
//  ArticlesList.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 19.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticlesList : View {
    var articles: [Article]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ForEach(articles, id: \.self) { article in
                    NavigationLink(destination: SafariView(url: article.url)) {
                        ArticleRow(article: article)
                            .animation(.spring())
                    }
                }
            }
        }
    }
}
