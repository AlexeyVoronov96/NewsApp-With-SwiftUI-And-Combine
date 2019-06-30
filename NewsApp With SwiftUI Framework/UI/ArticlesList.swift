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
        ScrollView(showsHorizontalIndicator: false, showsVerticalIndicator: true) {
            VStack(alignment: .center) {
                ForEach(self.articles.identified(by: \.self)) { article in
                    PresentationButton(destination: SafariView(url: article.url)) {
                        ArticleRow(article: article)
                            .animation(.spring())
                    }
                }
            }
        }
    }
}
