//
//  AppError.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

public enum AppError: Error, Equatable {
    
    case decodingError(error: Error)
    case networkError(error: Error)
    case invalidBaseUrl(description: String)
    case invalidUrl(description: String)
    case missingCriticalField(String)
    case apiError(message: String)
    case httpError(statusCode: Int)
    case emptyData
    case noWeatherDataAvailable
    case invalidWeatherData
    case invalidAPIKey
    case invalidCityName
    case invalidTime
    case invalidResponse
    case unknownError

}

extension AppError {
    
    public static func getLocalizedErrorMessage(error: Error) -> String {
        var errorMessage: String = ""
        
        switch error {
        case let appError as AppError:
            switch appError {
            case .invalidResponse:
                errorMessage = "The response received is invalid."
            case .unknownError:
                errorMessage =  "An unknown error occurred."
            case .decodingError(let error):
                errorMessage =  "Decoding error: \(error.localizedDescription)"
            case .invalidBaseUrl(let description), .invalidUrl(let description):
                errorMessage =  "Invalid URL: \(description)"
            case .httpError(let statusCode):
                errorMessage =  "HTTP Error with status code \(statusCode)."
            case .emptyData:
                errorMessage =  "Received empty data from the server."
            case .noWeatherDataAvailable:
                errorMessage =  "No weather data available."
            case .invalidWeatherData:
                errorMessage =  "The weather data is invalid."
            case .missingCriticalField(let field):
                errorMessage =  "Missing critical field: \(field)"
            case .invalidAPIKey:
                errorMessage =  "Invalid API key."
            case .invalidCityName:
                errorMessage =  "Invalid city name."
            case .networkError(let error):
                errorMessage =  "Network error: \(error.localizedDescription)"
            case .apiError(let message):
                errorMessage =  "API Error: \(message)"
            case .invalidTime:
                errorMessage =  "Invalid Time."
            }
        default:
            errorMessage = "An unexpected error occurred."
        }
        return errorMessage
    }
    
    public static func == (lhs: AppError, rhs: AppError) -> Bool {
            switch (lhs, rhs) {
            case (.invalidResponse, .invalidResponse),
                 (.unknownError, .unknownError),
                 (.emptyData, .emptyData),
                 (.noWeatherDataAvailable, .noWeatherDataAvailable),
                 (.invalidWeatherData, .invalidWeatherData),
                 (.invalidAPIKey, .invalidAPIKey),
                 (.invalidCityName, .invalidCityName):
                return true
            case (.decodingError(let lhsError), .decodingError(let rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            case (.invalidBaseUrl(let lhsDescription), .invalidBaseUrl(let rhsDescription)),
                 (.invalidUrl(let lhsDescription), .invalidUrl(let rhsDescription)):
                return lhsDescription == rhsDescription
            case (.httpError(let lhsStatusCode), .httpError(let rhsStatusCode)):
                return lhsStatusCode == rhsStatusCode
            case (.missingCriticalField(let lhsField), .missingCriticalField(let rhsField)):
                return lhsField == rhsField
            case (.networkError(let lhsError), .networkError(let rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            default:
                return false
            }
        }
}
