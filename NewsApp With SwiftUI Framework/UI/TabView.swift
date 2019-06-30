//
//  TabView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TabView : View {
    var body: some View {
        TabbedView {
            MainView()
                .tabItemLabel(Image("top_headlines"))
                .tag(0)
            
            SourcesListView()
                .tabItemLabel(Image("sources"))
                .tag(1)
            
            SearchForArticlesView()
                .tabItemLabel(Image("search"))
                .tag(2)
        }
        .accentColor(.black)
    }
}
