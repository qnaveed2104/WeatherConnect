//
//  WeatherRow.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct WeatherRow: View {
    let forecast: WeatherDisplayData
    var body: some View {
        HStack {
            
            WeatherViewWithTheme(forecast.fomattedTime, style: .textRegular)
                .padding(.leading, 5)
            WeatherViewWithTheme(forecast.formatedTemp, style: .title)
            WeatherViewWithTheme(forecast.skyCondition, style: .textRegular)
            Spacer()
        }
        .padding(.vertical, 20)
        .background(AppColors.primaryBackground.color) 

    }
}

#Preview {
    WeatherRow(forecast: WeatherDisplayData(
        cityName: nil,
        formatedTemp: "20°C",
        fomattedTime: "16:00",
        skyCondition: "Clear")
    )
}
