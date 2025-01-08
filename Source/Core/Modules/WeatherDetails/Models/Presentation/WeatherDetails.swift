//
//  WeatherDetails.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

struct WeatherDetails {
    let currentWeather: WeatherDisplayData?
    let weatherForecast: [WeatherDisplayData]
    
    var isEmpty: Bool {
        currentWeather?.cityName == nil && weatherForecast.isEmpty
    }
}
