//
//  TopHeadlineRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Combine
import SwiftUI

struct TopHeadlineRow : View {
    @State private var headlineImage = UIImage(named: "logo")
    
    private let placeholder = #imageLiteral(resourceName: "logo")
    
    var article: Article
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: headlineImage ?? placeholder)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(4 / 3, contentMode: .fit)
                .onAppear(perform: downloadWebImage)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width / 4 * 3,
                       alignment: .center)
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.6)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width / 4 * 3,
                       alignment: .center)
            
            topHeadlineInfo
        }
    }
    
    private var topHeadlineInfo: some View {
        NavigationLink(destination: SafariView(url: article.url)) {
            VStack {
                Text(verbatim: article.source?.name ?? "")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .lineLimit(nil)
                    .padding([.leading, .trailing])
                    .frame(width: UIScreen.main.bounds.width,
                           alignment: .bottomLeading)
                
                Text(verbatim: article.title ?? "")
                    .foregroundColor(.white)
                    .font(.headline)
                    .lineLimit(nil)
                    .padding([.leading, .bottom, .trailing])
                    .frame(width: UIScreen.main.bounds.width,
                           alignment: .bottomLeading)
            }
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
