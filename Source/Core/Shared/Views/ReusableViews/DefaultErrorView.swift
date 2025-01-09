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
        AppError.getLocalizedErrorMessage(error: error)
    }
}

#Preview {
    DefaultErrorView(error: AppError.invalidAPIKey)
        .background(Color(uiColor: .systemBackground)) // Explicitly add background
        .preferredColorScheme(.dark) // Preview in dark mode
}
