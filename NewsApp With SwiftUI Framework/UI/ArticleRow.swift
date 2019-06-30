//
//  ArticleRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticleRow : View {
    @State private var headlineImage = UIImage(named: "logo")
    
    private let placeholder = UIImage(named: "logo")!
    
    var article: Article
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: headlineImage ?? placeholder)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .onAppear(perform: downloadWebImage)
                .frame(width: Length(UIScreen.main.bounds.width - 16),
                       height: Length(250),
                       alignment: .center)
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.6)
            
            Text(verbatim: article.title ?? "")
                .color(.white)
                .frame(width: Length(UIScreen.main.bounds.width - 64),
                       alignment: .bottomLeading)
                .font(.headline)
                .lineLimit(nil)
                .padding()
        }
        .cornerRadius(8)
        .padding([.leading, .trailing], 8)
    }
    
    private func downloadWebImage() {
        guard let url = URL(string: article.urlToImage ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data, let image = UIImage(data: data) {
                self.headlineImage = image
            }
            }
            .resume()
    }
}
