//
//  WeatherService.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherServiceProtocol {
    var repository: WeatherRepositoryProtocol { get }
    var weatherSDKDelegate: WeatherSDKDelegate { get }
    func loadCurrentWeather() async throws -> WeatherDisplayData
    func loadWeatherForecast() async throws -> [WeatherDisplayData]
    func dismissWeatherSDK(error: Error?)
}

struct WeatherService: WeatherServiceProtocol {
    let weatherSDKDelegate: WeatherSDKDelegate
    let repository: WeatherRepositoryProtocol
    
    func loadCurrentWeather() async throws -> WeatherDisplayData {
        let weatherDataArray = try await fetchWeatherData(fetchOperation: repository.fetchCurrentWeather)
        guard let weatherData = weatherDataArray.first else {
            throw AppError.invalidResponse
        }
        return createWeatherDisplayData(from: weatherData, isCurrentWeather: true)
    }
    
    func loadWeatherForecast() async throws -> [WeatherDisplayData] {
        // Fetch weather data from the repository
        let weatherDataArray = try await fetchWeatherData(fetchOperation: repository.fetchWeatherForcast)
        
        // Get the next full hour, or throw an error if unavailable
        let nextFullHour = try Date.nextHourRoundDate() ?? {
            throw AppError.invalidTime
        }()
        
        // Filter and map weather data
        let filteredForecastData = weatherDataArray
            .compactMap { forecast -> WeatherDisplayData? in
                guard
                    let forecastDate = Date.parseForecastTimestamp(forecast.timestampLocal),
                    forecastDate >= nextFullHour
                else {
                    return nil
                }
                return createWeatherDisplayData(from: forecast, isCurrentWeather: false)
            }
            .prefix(24)
        
        return Array(filteredForecastData)
    }
    
    func dismissWeatherSDK(error: Error?) {
        if let error = error {
            weatherSDKDelegate.onFinishedWithError(error)
        } else {
            weatherSDKDelegate.onFinished()
        }
    }
    
    private func fetchWeatherData(
        fetchOperation: () async throws -> WeatherResponse
    ) async throws -> [WeatherData] {
        let weatherResponse = try await fetchOperation()
        guard let data = weatherResponse.data, !data.isEmpty else {
            throw AppError.invalidResponse
        }
        return data
    }
    
    private func createWeatherDisplayData(from data: WeatherData, isCurrentWeather: Bool) -> WeatherDisplayData {
        WeatherDisplayData(
            cityName: isCurrentWeather
            ? String(format: AppConstants.DisplayFormats.formatedCityName, data.cityName ?? "NA")
            : (nil),
            formatedTemp: String(format: AppConstants.DisplayFormats.temperature, data.temp),
            fomattedTime: (isCurrentWeather
                           ? formatUnixTimestamp(data.ts)
                           : data.timestampLocal?.getlocalTime()
                          ) ?? "NA",
            skyCondition: data.weather.description
        )
    }
    
    private func formatUnixTimestamp(_ timestamp: Int?) -> String {
        guard let timestamp = timestamp else {
            return "NA"
        }
        let time = Date.timeFromUnixTimestamp(timestamp: TimeInterval(timestamp))
        return String(format: AppConstants.DisplayFormats.lcoalTime, time)
    }
}
