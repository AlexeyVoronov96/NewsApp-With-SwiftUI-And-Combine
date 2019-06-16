//
//  SourcesList.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct SourcesList : View {
    @State private var sources: [Source] = []
    
    private let apiProvider = APIProvider()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.sources.identified(by: \.self)) { source in
                    NavigationButton(
                        destination: NewsList(source: source.id)
                            .navigationBarTitle(Text(source.name))
                    ) {
                        Text(source.name)
                        }
                }
            }
            .onAppear {
                self.getSources()
            }
            .navigationBarTitle(Text("Sources".localized()), displayMode: .large)
        }
    }
    
    private func getSources() {
        apiProvider.getSources(completion: { (sources, error) in
            guard let sourcesList = sources?.sources else { return }
            self.sources = sourcesList
        })
    }
}
