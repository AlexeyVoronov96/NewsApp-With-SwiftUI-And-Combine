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
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                }
            }
            .navigationBarTitle(Text(verbatim: viewModel.locationName), displayMode: .large)
        }
        .onAppear {
            self.viewModel.getCityName()
            self.viewModel.getCurrentWeather()
        }
    }
    
    private var currentWeatherSection: some View {
        Section(header: Text(verbatim: Constants.currentWeather)) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(systemName: viewModel.weather?.currently.icon.systemImage ?? Constants.defaultImageName)
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
        Section(header: Text(verbatim: Constants.hourly)) {
            HourlyWeatherView(hourlyWeather: viewModel.weather?.hourly.data ?? [])
        }
    }
    
    private var dailyWeatherSection: some View {
        Section(header: Text(verbatim: Constants.daily)) {
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

private extension WeatherView {
    
    struct Constants {
        static let currentWeather = "Current weather".localized()
        static let defaultImageName = "sun.min.fill"
        static let hourly = "Hourly".localized()
        static let daily = "Daily".localized()
    }
}
