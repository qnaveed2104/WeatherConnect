//
//  DefaultErrorView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct DefaultErrorView: View {
    let error: Error
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            WeatherViewWithTheme("An error occurred", style: .heading1, color: Color.red)
            WeatherViewWithTheme(errorMessage, style: .customFont).padding(.horizontal)
            Spacer()
        }
        .background(AppColors.primaryBackground.color)

    }
        private var errorMessage: String {
            switch error {
            case let appError as AppError:
                switch appError { 
                case .invalidResponse:
                    return "The response received is invalid."
                case .unknownError:
                    return "An unknown error occurred."
                case .decodingError(let error):
                    return "Decoding error: \(error.localizedDescription)"
                case .invalidBaseUrl(let description), .invalidUrl(let description):
                    return "Invalid URL: \(description)"
                case .httpError(let statusCode):
                    return "HTTP Error with status code \(statusCode)."
                case .emptyData:
                    return "Received empty data from the server."
                case .githubTokenNotfound:
                    return "GitHub token not found."
                case .noWeatherDataAvailable:
                    return "No weather data available."
                case .invalidWeatherData:
                    return "The weather data is invalid."
                case .missingCriticalField(let field):
                    return "Missing critical field: \(field)"
                case .invalidAPIKey:
                    return "Invalid API key."
                case .invalidCityName:
                    return "Invalid city name."
                case .networkError(let error):
                    return "Network error: \(error.localizedDescription)"
                case .apiError(let message):
                    return "API Error: \(message)"
                case .invalidTime:
                    return "Invalid Time."
                }
            default:
                return error.localizedDescription
            }
        }
}

#Preview {
    DefaultErrorView(error: AppError.invalidAPIKey)
        .background(Color(uiColor: .systemBackground)) // Explicitly add background
        .preferredColorScheme(.dark) // Preview in dark mode
}
