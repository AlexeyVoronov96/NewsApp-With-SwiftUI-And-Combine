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
            
            Text(verbatim: article.title ?? "")
                .color(.white)
                .frame(width: UIScreen.main.bounds.width - 64,
                       alignment: .bottomLeading)
                .font(.headline)
                .lineLimit(nil)
                .padding()
        }
        .cornerRadius(8)
        .padding([.leading, .trailing], 16)
        .padding([.top, .bottom], 8)
        .shadow(color: .black, radius: 3, x: 0, y: 0)
    }
    
    private func downloadWebImage() {
        guard let url = URL(string: article.urlToImage ?? "") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .replaceError(with: Data())
            .map({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: RunLoop.main)
            .sink { (image) in
                self.headlineImage = image
            }
            .receive(completion: Subscribers.Completion<Never>.finished)
    }
}
