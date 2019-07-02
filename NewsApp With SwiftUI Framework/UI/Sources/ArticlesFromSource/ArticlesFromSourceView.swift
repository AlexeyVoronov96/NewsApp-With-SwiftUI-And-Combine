//
//  NewsList.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticlesFromSourceView: View {
    @ObjectBinding var viewModel = ArticlesFromSourceViewModel()
    @State private var isInfo: Bool = false
    
    var source: Source
    
    var body: some View {
        ScrollView(showsHorizontalIndicator: false) {
            VStack(alignment: .center) {
                if isInfo {
                    Text(verbatim: "About source:\n".localized() + (source.description ?? ""))
                        .lineLimit(nil)
                        .frame(width: Length(UIScreen.main.bounds.width - 32),
                               height: Length(150),
                               alignment: .center)
                }
                ForEach(viewModel.articles.identified(by: \.self)) { article in
                    PresentationButton(destination: SafariView(url: article.url)) {
                        ArticleRow(article: article)
                            .animation(.spring())
                    }
                }
            }
            .animation(.spring())
        }
        .onAppear(perform: {
            self.viewModel.getArticles(from: self.source.id)
        })
        .navigationBarItems(trailing:
            Button(action: {
                self.isInfo.toggle()
            }) {
                Image(systemName: isInfo ? "info.circle.fill" : "info.circle")
                    .accentColor(.black)
                    .imageScale(.large)
            }
        )
    }
}
