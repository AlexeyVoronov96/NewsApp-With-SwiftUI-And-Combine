//
//  TopHeadlineRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TopHeadlineRow : View {
    @State private var headlineImage = UIImage(named: "logo")
    
    private let placeholder = UIImage(named: "logo")!
    
    var article: Article
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: headlineImage ?? placeholder)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .onAppear(perform: downloadWebImage)
                .frame(width: Length(250),
                       height: Length(250),
                       alignment: .center)
                .cornerRadius(8)
            
            Text(verbatim: article.title ?? "")
                .frame(width: 250, height: 50)
                .font(.subheadline)
                .lineLimit(2)
        }
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
