//
//  CurrentWeatherView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct CurrentWeatherView: View {
    let currentWeather: WeatherDisplayData?
    
    var body: some View {
        VStack {
            if let weather = currentWeather {
                VStack(spacing: 8) {
                    WeatherViewWithTheme(weather.cityName ?? "", style: .textRegular)
                    WeatherViewWithTheme(weather.formatedTemp, style: .heading1)
                    WeatherViewWithTheme(weather.skyCondition, style: .textRegular)
                    WeatherViewWithTheme(weather.fomattedTime, style: .label, color: AppColors.textSecondary.color)
                }
                .padding()
            } else {
                DefaultLoadingView(loadingText: "Loading current weather...")
                    .padding()

            }
        }

    }
    
}

#Preview {
    CurrentWeatherView(currentWeather: WeatherDisplayData(
        cityName: "Berlin",
        formatedTemp: "20°C",
        fomattedTime: "AT LOCAL TIME 16:00)",
        skyCondition: "Clear")
    )
}
