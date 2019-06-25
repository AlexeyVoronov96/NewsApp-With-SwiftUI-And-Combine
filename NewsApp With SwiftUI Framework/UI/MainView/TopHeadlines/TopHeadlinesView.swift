//
//  TopHeadlinesView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TopHeadlinesView : View {
    @ObjectBinding var viewModel: MainViewModel
    
    var body: some View {
        ScrollView(showsHorizontalIndicator: false) {
            HStack(alignment: .center, spacing: 8) {
                ForEach(self.viewModel.topHeadlines.identified(by: \.self)) { article in
                    TopHeadlineRow(imageURL: article.urlToImage ?? "")
                }
            }
        }
        .onAppear {
            self.viewModel.getTopHeadlines()
        }
    }
}
