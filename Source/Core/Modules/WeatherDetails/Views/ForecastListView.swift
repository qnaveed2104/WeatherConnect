//
//  ForecastListView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct ForecastListView: View {
    let weatherForecast: [WeatherDisplayData]
    
    var body: some View {
        if weatherForecast.isEmpty {
            // Show a loader when the forecast is empty
            DefaultLoadingView(loadingText: "Loading forecast...")
                .padding()
                .background(AppColors.primaryBackground.color)
        } else {
            // Display a list of forecasts
            List(weatherForecast, id: \.fomattedTime) { forecast in
                WeatherRow(forecast: forecast)
                    .listRowSeparatorTint(AppColors.textBorder.color)
                    .listRowInsets(EdgeInsets())
                
            }
            .listStyle(.plain)
            .background(AppColors.primaryBackground.color)
        }
    }
}

#Preview {
    ForecastListView(weatherForecast: [WeatherDisplayData(
        cityName: nil,
        formatedTemp: "20°",
        fomattedTime: "16:00",
        skyCondition: "Clear")])
}
