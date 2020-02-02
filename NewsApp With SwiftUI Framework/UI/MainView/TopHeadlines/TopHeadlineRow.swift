//
//  TopHeadlineRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Combine
import KingfisherSwiftUI
import SwiftUI

struct TopHeadlineRow : View {
    @State private var shouldPresentURL: Bool = false
    @State private var shouldShowShareSheet: Bool = false
    
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
        .contextMenu {
            Button(
                action: {
                    LocalArticle.saveArticle(self.article)
                    CoreDataManager.shared.saveContext()
                },
                label: {
                    Text("Add to favorites".localized())
                    Image(systemName: "heart.fill")
                }
            )
            Button(
                action: {
                    self.shouldShowShareSheet.toggle()
                },
                label: {
                    Text("Share".localized())
                    Image(systemName: "square.and.arrow.up")
                }
            )
        }
        .sheet(isPresented: $shouldPresentURL) {
            SafariView(url: self.article.url)
        }
        .sheet(isPresented: $shouldShowShareSheet) {
            ActivityViewController(activityItems: [
                self.article.title ?? "",
                self.article.url
            ])
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
