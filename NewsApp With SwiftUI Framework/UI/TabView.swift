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
            OverView().tabItemLabel(Image("top_headlines")).tag(1)
            SourcesList().tabItemLabel(Image("sources")).tag(2)
            SearchForSourcesList().tabItemLabel(Image("search")).tag(3)
        }
    }
}
