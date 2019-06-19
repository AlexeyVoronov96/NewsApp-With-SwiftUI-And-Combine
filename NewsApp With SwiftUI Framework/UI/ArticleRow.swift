//
//  ArticleRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct ArticleRow : View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(verbatim: article.title ?? "")
                .lineLimit(nil)
            Text(verbatim: article.description ?? "")
                .color(.gray)
                .lineLimit(nil)
        }
        .padding()
    }
}
