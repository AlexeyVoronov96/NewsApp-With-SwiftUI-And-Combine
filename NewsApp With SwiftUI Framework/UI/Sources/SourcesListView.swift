//
//  SourcesListView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct SourcesListView : View {
    @ObjectBinding var viewModel = SourcesListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.sources.identified(by: \.self)) { source in
                    NavigationButton(
                        destination: ArticlesFromSourceView(source: source.id)
                            .navigationBarTitle(Text(source.name))
                    ) {
                        Text(source.name)
                    }
                }
            }
            .onAppear {
                self.viewModel.getSources()
            }
            .navigationBarTitle(Text("Sources".localized()), displayMode: .large)
        }
    }
}
