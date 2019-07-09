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
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                if isInfo {
                    Text(verbatim: "About source:\n".localized() + (source.description ?? ""))
                        .lineLimit(nil)
                        .frame(width: Length(UIScreen.main.bounds.width - 32),
                               height: Length(150),
                               alignment: .center)
                }
                
                ForEach(viewModel.articles.identified(by: \.self)) { article in
                    PresentationLink(destination: SafariView(url: article.url)) {
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
            HStack {
                if self.source.description != nil {
                    Button(action: {
                        self.isInfo.toggle()
                    }) {
                        Image(systemName: isInfo ? "info.circle.fill" : "info.circle")
                            .imageScale(.large)
                    }
                }
                Button(action: {
                    UIApplication.shared.open(self.source.url)
                }) {
                    Image(systemName: "safari")
                        .imageScale(.large)
                }
            }
        )
    }
}
