//
//  WeatherData.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

struct WeatherData: Codable {
    let timestampLocal: String?
    let appTemp: Double?
    let aqi: Int?
    let cityName: String?
    let clouds: Int?
    let countryCode: String?
    let datetime: String
    let dewpt: Double?
    let dhi: Double?
    let dni: Double?
    let elevAngle: Double?
    let ghi: Double?
    let gust: Double?
    let hAngle: Double?
    let lat: Double?
    let lon: Double?
    let obTime: String?
    let pod: String
    let precip: Float?
    let pres: Float?
    let rh: Float?
    let slp: Float?
    let snow: Double?
    let solarRad: Double?
    let sources: [String]?
    let stateCode: String?
    let station: String?
    let sunrise: String?
    let sunset: String?
    let temp: Double
    let timezone: String?
    let ts: Int?
    let uv: Int?
    let vis: Float?
    let weather: Weather
    let windCdir: String
    let windCdirFull: String
    let windDir: Double
    let windSpd: Double
}
