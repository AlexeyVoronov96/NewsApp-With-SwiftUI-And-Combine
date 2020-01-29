//
//  SourceRow.swift
//  SwiftUI Demo
//
//  Created by Алексей Воронов on 15.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct SourceRow : View {
    let source: Source
    
    var body: some View {
        HStack {
            Text(source.name)
        }
    }
}
