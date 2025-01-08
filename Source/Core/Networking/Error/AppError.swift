//
//  AppError.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

public enum AppError: Error, Equatable {
    public static func == (lhs: AppError, rhs: AppError) -> Bool {
            switch (lhs, rhs) {
            case (.invalidResponse, .invalidResponse),
                 (.unknownError, .unknownError),
                 (.emptyData, .emptyData),
                 (.githubTokenNotfound, .githubTokenNotfound),
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
    case invalidResponse
    case unknownError
    case decodingError(error: Error)
    case invalidBaseUrl(description: String)
    case invalidUrl(description: String)
    case httpError(statusCode: Int)
    case emptyData
    case githubTokenNotfound
    case noWeatherDataAvailable
    case invalidWeatherData
    case missingCriticalField(String)
    case invalidAPIKey
    case invalidCityName
    case networkError(error: Error)
    case apiError(message: String)
    case invalidTime
}
