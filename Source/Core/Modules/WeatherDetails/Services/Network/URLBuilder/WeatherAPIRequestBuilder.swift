//
//  WeatherAPIRequestBuilder.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//
import Foundation

protocol WeatherRequestBuilderProtocol: APIClientRequestBuilderProtocol {
    
    var configurations: Configurations { get }
    func buildCurrentWeatherURLRequest() throws -> URLRequest
    func buildweatherForecastURLRequest() throws -> URLRequest
}

struct WeatherRequestBuilder: WeatherRequestBuilderProtocol {
    let configurations: Configurations
        
    func buildCurrentWeatherURLRequest() throws -> URLRequest {
        return try buildURLRequest(
            path: AppConstants.API.urlFromEndpoint(endpoint: AppConstants.API.currentWeatherEndpoint),
            queryParams: [
                AppConstants.API.apiKey: configurations.apiKey,
                AppConstants.API.cityKey: configurations.cityName,
                AppConstants.API.langKey: configurations.language ?? "en"
            ]
        )
    }
    
    func buildweatherForecastURLRequest() throws -> URLRequest {
        return try buildURLRequest(
            path: AppConstants.API.urlFromEndpoint(endpoint: AppConstants.API.weatherForcastEndpoint),
            queryParams: [
                AppConstants.API.apiKey: configurations.apiKey,
                AppConstants.API.cityKey: configurations.cityName,
                AppConstants.API.langKey: configurations.language ?? "en",
                AppConstants.API.hoursKey: String(configurations.hours)
            ]
        )
    }
}
