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
        TabbedView() {
            OverView().tabItemLabel(Text("Overview")).tag(1)
            SourcesList().tabItemLabel(Text("Sources")).tag(2)
            SearchForSourcesList().tabItemLabel(Text("Search")).tag(3)
        }
    }
}
