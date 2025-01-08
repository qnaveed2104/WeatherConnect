//
//  Configurations.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

/// A struct that holds the configuration parameters for initializing the WeatherSDK.
///
/// This struct is used to provide necessary configuration details such as an API key,
/// the city for weather information, and the preferred language for the response.
///
/// Example usage:
/// ```
/// let config = Configurations(apiKey: "your_api_key", cityName: "Berlin")
/// ```
///
public struct Configurations {
    let apiKey: String
    let cityName: String
    let language: String?
    let hours: Int = 25
    
    /// Configuration from which WeatherSDK initiliaze
    /// - Parameters:
    ///   - apiKey: key use to authenticate request  from weather services like "Weatherbit"
    ///   - cityName: e,g "Berlin", "Munich"
    ///   - language: response language e,g en, de
    ///               if not provided default is en
    ///
    ///   - Returns: A new instance of `Configurations` with the provided parameters.

    public init(apiKey: String, cityName: String, language: String = "en") {
        self.apiKey = apiKey
        self.cityName = cityName
        self.language = language
    }
}
