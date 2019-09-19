//
//  ArticleRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Combine
import SwiftUI

struct ArticleRow : View {
    @State private var headlineImage = UIImage(named: "logo")
    
    private let placeholder = #imageLiteral(resourceName: "logo")
    
    var article: Article
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: headlineImage ?? placeholder)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .onAppear(perform: downloadWebImage)
                .frame(width: UIScreen.main.bounds.width - 32,
                       height: 250,
                       alignment: .center)
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.6)
            
            articleInfo
        }
        .cornerRadius(8)
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 8)
        .shadow(color: .black, radius: 3, x: 0, y: 0)
    }
    
    private var articleInfo: some View {
        VStack {
            Text(verbatim: article.source?.name ?? "")
                .foregroundColor(.white)
                .font(.subheadline)
                .lineLimit(nil)
                .padding([.leading, .trailing])
                .frame(width: UIScreen.main.bounds.width - 64,
                       alignment: .bottomLeading)
            
            Text(verbatim: article.title ?? "")
                .foregroundColor(.white)
                .font(.headline)
                .lineLimit(nil)
                .padding([.leading, .bottom, .trailing])
                .frame(width: UIScreen.main.bounds.width - 64,
                       alignment: .bottomLeading)
        }
    }
    
    private func downloadWebImage() {
        guard let url = URL(string: article.urlToImage ?? "") else { return }
        
        _ = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .replaceError(with: Data())
            .map({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: RunLoop.main)
            .sink { (image) in
                self.headlineImage = image
            }
    }
}
