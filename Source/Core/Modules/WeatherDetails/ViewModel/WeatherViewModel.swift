//
//  WeatherViewModel.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherViewModelProtocol: ObservableObject {
    var service: WeatherServiceProtocol { get }
    var currentWeather: WeatherDisplayData? { get set}
    var weatherForecast: [WeatherDisplayData] { get set}
    func fetchWeatherData() async
    func dismissSDK()
}

class WeatherViewModel: WeatherViewModelProtocol, AppStateProtocol {
    typealias ContentType = WeatherDetails
    @Published var state: AppState<WeatherDetails>
    var currentWeather: WeatherDisplayData?
    var weatherForecast: [WeatherDisplayData] = []
    
    let service: WeatherServiceProtocol
    
    init(service: WeatherServiceProtocol) {
        self.service = service
        self.state = .idle
    }
    
    @MainActor
    func fetchWeatherData() async {
        self.state = .loading
        do {
            let currentWeatherTask = Task { try await self.loadCurrentWeather() }
            let weatherForecastTask = Task { try await self.loadWeatherForecast() }
            
            let currentWeather = try await currentWeatherTask.value
            let weatherForecast = try await weatherForecastTask.value
            
            let weatherDetails = WeatherDetails(currentWeather: currentWeather, weatherForecast: weatherForecast)
            
            if weatherDetails.isEmpty {
                self.state = .empty
            } else {
                self.state = .success(weatherDetails)
            }
        } catch {
            self.state = .failed(error as? AppError ?? AppError.unknownError)
        }
    }
    
    private func loadCurrentWeather() async throws -> WeatherDisplayData? {
        return try await service.loadCurrentWeather()
    }
    
    private func loadWeatherForecast() async throws -> [WeatherDisplayData] {
        return try await service.loadWeatherForecast()
    }
    
    func dismissSDK() {
        let extractedError: AppError? = {
            if case let .failed(error) = state {
                return error
            }
            return nil
        }()
        service.dismissWeatherSDK(error: extractedError)
    }
}
