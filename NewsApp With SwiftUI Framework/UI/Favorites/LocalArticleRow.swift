//
//  LocalArticleRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 28.01.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct LocalArticleRow: View {
    let article: LocalArticle
    
    @State private var shouldShowShareSheet: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(URL(string: article.urlToImage ?? ""))
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
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
        .contextMenu {
            Button(
                action: {
                    CoreDataManager.shared.managedObjectContext.delete(self.article)
                    CoreDataManager.shared.saveContext()
                },
                label: {
                    Text(Constants.removeFromFavorites)
                    Image(systemName: Constants.removeFromFavoritesImageName)
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
        .sheet(isPresented: $shouldShowShareSheet) {
            ActivityViewController(activityItems: [
                self.article.title ?? "",
                self.article.url as Any
            ])
        }
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
}

private extension LocalArticleRow {
    
    struct Constants {
        static let removeFromFavorites = "Remove from favorites".localized()
        static let removeFromFavoritesImageName = "heart.slash.fill"
    }
}
