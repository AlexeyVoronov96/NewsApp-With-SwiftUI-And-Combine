//
//  OverView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct OverView : View {
    @State private var topHeadlines: [Article] = []
    private var categories: [String] = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    var body: some View {
        NavigationView {
            List {
                TopHeadlines()
                .frame(height: 200)
                
                ForEach(self.categories.identified(by: \.self)) { category in
                    NavigationButton(
                        destination: ArticlesFromCategory(category: category)
                    ) {
                        Text(category)
                    }
                }
            }
            .onAppear {
                self.getCategories()
            }
            .navigationBarTitle(Text("Overview"), displayMode: .large)
        }
    }
    
    private func getCategories() {
        
    }
}
