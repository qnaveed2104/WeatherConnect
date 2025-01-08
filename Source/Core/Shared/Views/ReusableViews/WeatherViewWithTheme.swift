//
//  WeatherViewWithTheme.swift
//  WeatherCore
//
//  Created by Qazi on 07/01/2025.
//

import SwiftUI

struct WeatherViewWithTheme: View {
    let text: String
        let style: ThemeFonts.FontType
        let color: Color?
        
    init(_ text: String, style: ThemeFonts.FontType, color: Color = AppColors.textPrimary.color) {
            self.text = text
            self.style = style
            self.color = color
        }
        
        var body: some View {
            let fontStyle = ThemeFonts.fontStyle(for: style)
            Text(text)
                .font(fontStyle.font)
                .lineSpacing(fontStyle.lineSpacing)
                .foregroundColor(color ?? Color.primary)
        }
}

#Preview {
    WeatherViewWithTheme("Berlin", style: .heading1)
}
