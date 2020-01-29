//
//  ArticlesList.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 19.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticlesList : View {
    @State var shouldPresent: Bool = false
    @State var articleURL: URL?
    
    let articles: [Article]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ForEach(articles, id: \.self) { article in
                    Button(
                        action: {
                            self.articleURL = article.url
                            self.shouldPresent = true
                        },
                        label: {
                            ArticleRow(article: article)
                                .animation(.spring())
                        }
                    )
                }
            }
        }
        .sheet(isPresented: $shouldPresent) {
            SafariView(url: self.articleURL!)
        }
    }
}
