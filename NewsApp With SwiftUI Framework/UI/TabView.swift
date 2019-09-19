//
//  TabView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TabedView : View {
    var body: some View {
        TabView {
            MainView()
                .tabItem { Image("top_headlines") }
            
            SourcesListView()
                .tabItem { Image("sources") }
            
            SearchForArticlesView()
                .tabItem { Image("search") }
            
            WeatherView()
                .tabItem { Image("weather") }
        }
        .accentColor(.black)
    }
}
