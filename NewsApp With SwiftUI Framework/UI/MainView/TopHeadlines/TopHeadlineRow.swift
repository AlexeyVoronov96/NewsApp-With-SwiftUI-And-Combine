//
//  TopHeadlineRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TopHeadlineRow : View {
    @State private var headlineImage = UIImage(named: "article_placeholder")
    
    private let placeholder = UIImage(named: "article_placeholder")!
    
    var imageURL: String
    
    var body: some View {
        Image(uiImage: self.headlineImage ?? self.placeholder)
            .resizable()
            .scaledToFill()
            .onAppear(perform: downloadWebImage)
            .frame(width: Length(150),
                   height: Length(150),
                   alignment: .center)
            .cornerRadius(8)
    }
    
    private func downloadWebImage() {
        guard let url = URL(string: self.imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data, let image = UIImage(data: data) {
                self.headlineImage = image
            }
        }
        .resume()
    }
}
