//
//  MainView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct MainView : View {
    @ObjectBinding var viewModel = MainViewModel()
    
    private var categories: [String] = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    var body: some View {
        NavigationView(content: {
            List {
                if !viewModel.topHeadlines.isEmpty {
                    TopHeadlinesView(topHeadlines: viewModel.topHeadlines)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                        .frame(height: 250, alignment: .center)
                }
                
                Section(header: Text(verbatim: "Categories".localized())) {
                    ForEach(self.categories.identified(by: \.self)) { category in
                        NavigationLink(
                            destination: ArticlesFromCategoryView(category: category)
                                .navigationBarTitle(Text(category.localized().capitalizeFirstLetter()), displayMode: .large)
                        ) {
                            Text(category.localized().capitalizeFirstLetter())
                        }
                    }
                }
            }
            .animation(.spring())
            .onAppear(perform: {
                self.viewModel.getTopHeadlines()
            })
            .navigationBarTitle(Text("Overview".localized()), displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    self.viewModel.clearTopHeadlines()
                    self.viewModel.getTopHeadlines()
                }, label: {
                    Image(systemName: "arrow.2.circlepath")
                        .accentColor(.black)
                        .imageScale(.large)
                }))
        })
    }
}
