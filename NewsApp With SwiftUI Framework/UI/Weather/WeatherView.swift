//
//  WeatherView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 21.07.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack() {
                if viewModel.weather == nil {
                    ActivityIndicator()
                } else {
                    List(content: {
                        currentWeatherSection
                        hourlyWeatherSection
                        dailyWeatherSection
                    })
                }
            }
            .navigationBarTitle(Text(verbatim: "Weather".localized()), displayMode: .large)
        }
        .onAppear {
            self.viewModel.getCurrentWeather()
        }
    }
    
    private var currentWeatherSection: some View {
        Section(header: Text(verbatim: "Current weather".localized())) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(systemName: viewModel.weather?.currently.icon.systemImage ?? "sun.min.fill")
                        .font(.largeTitle)
                    Text(verbatim: viewModel.weather?.currently.convertTemperature ?? "")
                        .font(.largeTitle)
                }
                Text(verbatim: viewModel.weather?.hourly.summary ?? "")
                    .font(.subheadline)
                    .lineLimit(nil)
            }
        }
    }
    
    private var hourlyWeatherSection: some View {
        Section(header: Text(verbatim: "Hourly".localized())) {
            HourlyWeatherView(hourlyWeather: viewModel.weather?.hourly.data ?? [])
        }
    }
    
    private var dailyWeatherSection: some View {
        Section(header: Text(verbatim: "Daily".localized())) {
            ForEach(viewModel.weather?.daily.data ?? [], id: \.self) { weather in
                HStack() {
                    Text(verbatim: weather.time.day())
                    Spacer()
                    Image(systemName: weather.icon.systemImage)
                    Text(verbatim: weather.averageTemperature)
                }
            }
        }
    }
}
