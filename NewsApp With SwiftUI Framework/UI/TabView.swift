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
        TabbedView(content: {
            MainView()
                .tabItem({ Image("top_headlines") })
                .tag(0)
            
            SourcesListView()
                .tabItem({ Image("sources") })
                .tag(1)
            
            SearchForArticlesView()
                .tabItem({ Image("search") })
                .tag(2)
            
            WeatherView()
                .tabItem({ Image("weather") })
                .tag(3)
        })
        .accentColor(.black)
    }
}
