//
//  WeatherSDK.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation
import SwiftUI

/// A class responsible for interacting with the Weather SDK to fetch weather information.
///
/// This class manages the API key and provides a method to fetch weather data for a specific city.
/// It uses the provided `apiKey` to authenticate API requests.
public final class WeatherSDK {
    
    // MARK: - Properties
    public var configuration: Configurations
    public weak var delegate: WeatherSDKDelegate?

    public init(configuration: Configurations, delegate: WeatherSDKDelegate) throws {
        guard !configuration.apiKey.isEmpty else { throw AppError.invalidAPIKey }
        guard !configuration.cityName.isEmpty else { throw AppError.invalidCityName }
        self.configuration = configuration
        self.delegate = delegate
    }
    /// Returns the  view with the city weather details
    /// - Parameter city: name of city whch details to be feteched
    /// - Returns: View that show the details of the weather
    @MainActor public func getWeather() async -> AnyView {
        let viewModel = await createWeatherViewModel()
        return AnyView(WeatherView(viewModel: viewModel))
    }
    
    @MainActor
    private func createWeatherViewModel() async -> WeatherViewModel {
        let apiClient: APIClientProtocol = APIClient()
        let requestBuilder: WeatherRequestBuilderProtocol = WeatherRequestBuilder(configurations: configuration)
        let weatherRepository: WeatherRepositoryProtocol = WeatherRepository(
            apiClient: apiClient,
            builder: requestBuilder
        )
        let weatherservice: WeatherServiceProtocol = WeatherService(
            weatherSDKDelegate: self,
            repository: weatherRepository
        )
        let viewModel: WeatherViewModel =  WeatherViewModel(service: weatherservice)
        
        await viewModel.fetchWeatherData()
        return viewModel
    }
}

extension WeatherSDK: WeatherSDKDelegate {
    public func onFinished() {
        delegate?.onFinished()
    }
    
    public func onFinishedWithError(_ error: any Error) {
        delegate?.onFinishedWithError(error)
    }
}
