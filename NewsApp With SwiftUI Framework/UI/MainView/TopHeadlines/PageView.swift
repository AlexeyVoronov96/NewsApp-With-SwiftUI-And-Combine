//
//  PageView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 05.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI


struct PageView<Page: View>: View {
    private let viewControllers: [UIHostingController<Page>]
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    
    var body: some View {
        PageViewController(controllers: viewControllers)
    }
}
