//
//  TopHeadlineRow.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct TopHeadlineRow : View {
    var imageURL: URL? = nil
    @State private var headlinemage = UIImage(systemName: "star.fill")
    private let placeholder = UIImage(systemName: "star.fill")!
    
    var body: some View {
        Image(uiImage: self.headlinemage ?? self.placeholder)
            .resizable()
            .onAppear(perform: downloadWebImage)
            .frame(width: Length(150),
                   height: Length(150),
                   alignment: .center)
            .cornerRadius(8)
    }
    
    private func downloadWebImage() {
        guard let url = self.imageURL else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data, let image = UIImage(data: data) {
                self.headlinemage = image
            }
        }.resume()
    }
}
