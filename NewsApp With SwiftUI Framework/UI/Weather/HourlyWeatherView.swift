//
//  HourlyWeatherView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 21.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct HourlyWeatherView: View {
    var hourlyWeather: [HourlyWeather]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(hourlyWeather, id: \.self) { weather in
                    VStack(alignment: .center) {
                        Text(verbatim: weather.time.hour())
                            .font(.subheadline)
                        
                        Image(systemName: weather.icon.systemImage)
                            .font(.largeTitle)
                        
                        Text(verbatim: weather.convertTemperature)
                            .font(.headline)
                            .padding([.top], 4)
                    }
                }
            }
        }
    }
}
