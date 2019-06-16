//
//  TopHeadlines.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TopHeadlines : View {
    @State private var articles: [Article] = []
    
    private let apiProvider = APIProvider()
    
    var body: some View {
        ScrollView(showsHorizontalIndicator: false) {
            HStack(alignment: .center, spacing: 8) {
                ForEach(self.articles.identified(by: \.self)) { article in
                    TopHeadlineRow(imageURL: article.urlToImage)
                }
            }
            }
        .onAppear {
            self.getTopHeadlines()
        }
    }
    
    private func getTopHeadlines() {
        apiProvider.getTopHeadlines { (articles, error) in
            guard let articlesList = articles?.articles else { return }
            
            self.articles = articlesList
        }
    }
}

#if DEBUG
struct TopHeadlines_Previews : PreviewProvider {
    static var previews: some View {
        TopHeadlines()
    }
}
#endif
