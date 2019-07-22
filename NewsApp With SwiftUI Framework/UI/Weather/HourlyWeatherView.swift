//
//  HourlyWeatherView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 21.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct HourlyWeatherView: View {
    var hourlyWeather: [Weather]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 16) {
                ForEach(hourlyWeather, id: \.self) { weather in
                    VStack(alignment: .center) {
                        Text(verbatim: weather.time.hour())
                            .font(.subheadline)
                        
                        Image(systemName: weather.icon.systemImage)
                            .font(.largeTitle)
                        
                        Text(verbatim: weather.convertTemperature)
                            .frame(width: 50, alignment: .center)
                            .font(.headline)
                            .padding([.top], 4)
                    }
                    .frame(width: 50, alignment: .center)
                }
            }
        }
    }
}
