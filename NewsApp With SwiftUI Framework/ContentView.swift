//
//  SourcesList.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct SourcesList : View {
    @State var sources: [Source]
    var body: some View {
        NavigationView {
            List {
                ForEach(self.sources.identified(by: \.self)) { source in
                    NavigationButton(destination: Text("1")) {
                        Text(source.name)
                    }
                    .navigationBarTitle(Text("Sources"), displayMode: NavigationBarItem.TitleDisplayMode.large)
                }
            }
            .onAppear {
                APIProvider().getSources { (error, sources) in
                    guard let sourcesList = sources?.sources else { return }
                    self.sources = sourcesList
                }
            }
        }
    }
}

#if DEBUG
struct SourcesList_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(sources: [])
    }
}
#endif
