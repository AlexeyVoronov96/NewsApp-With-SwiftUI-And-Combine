//
//  TopHeadlineRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Combine
import Kingfisher
import SwiftUI

struct TopHeadlineRow : View {
    @State var shouldPresentURL: Bool = false
    @State var selectedURL: URL?
    
    var article: Article
    
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(URL(string: article.urlToImage ?? ""))
                .renderingMode(.original)
                .resizable()
                .aspectRatio(4 / 3, contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width / 4 * 3,
                       alignment: .center)
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.6)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width / 4 * 3,
                       alignment: .center)
            
            Button(
                action: {
                    self.shouldPresentURL = true
                },
                label: {
                    topHeadlineInfo
                }
            )
        }
        .sheet(isPresented: $shouldPresentURL) {
            SafariView(url: self.article.url)
        }
    }
    
    private var topHeadlineInfo: some View {
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
