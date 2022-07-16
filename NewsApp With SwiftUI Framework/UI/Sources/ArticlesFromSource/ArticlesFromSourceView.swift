//
//  NewsList.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticlesFromSourceView: View {
    @ObservedObject var viewModel = ArticlesFromSourceViewModel()
    
    @State var articleURL: URL?
    
    let source: Source
    
    var body: some View {
        mainView
            .onAppear(perform: {
                self.viewModel.getArticles(from: self.source.id)
            })
            .sheet(item: $articleURL) { url in
                SafariView(url: url)
            }
            .navigationBarItems(trailing:
                HStack {
                    Button(
                        action: {
                            UIApplication.shared.open(self.source.url)
                        },
                        label: {
                            Image(systemName: "safari")
                                .imageScale(.large)
                        }
                    )
                }
            )
    }
    
    private var mainView: some View {
        VStack {
            if viewModel.articles.isEmpty {
                ActivityIndicator()
                    .frame(width: UIScreen.main.bounds.width,
                           height: 50,
                           alignment: .center)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center) {
                        if self.source.description != nil {
                            Text(verbatim: "About source:\n".localized() + (source.description ?? ""))
                                .lineLimit(nil)
                                .frame(width: UIScreen.main.bounds.width - 32,
                                       height: 150,
                                       alignment: .center)
                        }
                        ForEach(viewModel.articles, id: \.self) { article in
                            ArticleRow(article: article)
                            .animation(.spring())
                            .onTapGesture {
                                self.articleURL = article.url
                            }
                        }
                    }
                    .animation(.spring())
                }
            }
        }
    }
}
