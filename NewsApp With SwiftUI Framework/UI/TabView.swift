//
//  TabView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TabedView : View {
    private let context = CoreDataManager.shared.managedObjectContext
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "globe")
                        .font(.system(size: 22))
                }
            
            SourcesListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 22))
                }
            
            SearchForArticlesView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 22))
                }
            
            FavoritesView()
                .environment(\.managedObjectContext, context)
                .tabItem {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 22))
                }
            
            WeatherView()
                .tabItem {
                    Image(systemName: "cloud.sun.fill")
                        .font(.system(size: 22))
                }
        }
        .accentColor(.black)
    }
}
