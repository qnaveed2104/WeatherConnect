//
//  WeatherRepository.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherRepositoryProtocol {
    var apiClient: APIClientProtocol { get }
    var requestBuilder: WeatherRequestBuilderProtocol { get }
    func fetchCurrentWeather() async throws -> WeatherResponse
    func fetchWeatherForcast() async throws -> WeatherResponse
}

struct WeatherRepository: WeatherRepositoryProtocol {
    var requestBuilder: WeatherRequestBuilderProtocol
    let apiClient: APIClientProtocol
    init(apiClient: APIClientProtocol = APIClient(), builder: WeatherRequestBuilderProtocol) {
        self.apiClient = apiClient
        self.requestBuilder = builder
    }
    
    func fetchCurrentWeather() async throws -> WeatherResponse {
        let urlRequestforCurrentWeather = try requestBuilder.buildCurrentWeatherURLRequest()
        return try await fetchWeather(urlRequest: urlRequestforCurrentWeather)
    }
    
    func fetchWeatherForcast() async throws -> WeatherResponse {
        let urlRequestforWeatherForecast = try requestBuilder.buildweatherForecastURLRequest()
        return try await fetchWeather(urlRequest: urlRequestforWeatherForecast)
    }

    private func fetchWeather(urlRequest: URLRequest) async throws -> WeatherResponse {
        
        let result = await apiClient.getDataFromServer(
            urlRequest: urlRequest,
            responseType: WeatherResponse.self
        )
        
        switch result {
        case .success(let weatherResponse):
            return weatherResponse
        case .failure(let error):
            throw error
        }
    }
}
