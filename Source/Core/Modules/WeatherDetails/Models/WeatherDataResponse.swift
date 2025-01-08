//
//  WeatherDataResponse.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

struct WeatherResponse: Codable {
    let count: Int?
    let data: [WeatherData]?
    let cityName: String?
    let countryCode: String?

}
