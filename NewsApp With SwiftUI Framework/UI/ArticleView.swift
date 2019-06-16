//
//  ArticleView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticleView : View {
    private let placeholder = UIImage(named: "article_placeholder")!
    @State private var articleImage = UIImage(named: "article_placeholder")
    
    var article: Article
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: self.articleImage ?? self.placeholder)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                
                Text(verbatim: self.article.title)
                    .lineLimit(nil)
                    .font(.headline)
            }
            
            Text(verbatim: self.article.description ?? "")
                .lineLimit(nil)
                .font(.subheadline)
        }
        .padding()
        .onAppear {
            self.downloadWebImage()
        }
    }
    
    private func downloadWebImage() {
        guard let url = self.article.urlToImage else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data, let image = UIImage(data: data) {
                self.articleImage = image
        }
        }.resume()
    }
}
