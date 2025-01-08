//
//  AppColors.swift
//  WeatherCore
//
//  Created by Qazi on 07/01/2025.
//

import SwiftUI

enum AppColors {
    case accent
    case accentHighlighted
    case textPrimary
    case textSecondary
    case textPlaceholder
    case textBorder
    case navBarColor
    case primaryBackground
    
    var color: Color {
        switch self {
        case .accent:
            return Color("Accent", bundle: .module)
        case .accentHighlighted:
            return Color("AccentHighlighted", bundle: .module)
        case .textPrimary:
            return Color("TextPrimary", bundle: .module)
        case .textSecondary:
            return Color("TextSecondary", bundle: .module)
        case .textPlaceholder:
            return Color("TextPlaceholder", bundle: .module)
        case .textBorder:
            return Color("TextBorder", bundle: .module)
        case .navBarColor:
            return Color("NavBarColor", bundle: .module)
        case.primaryBackground:
            return Color("PrimaryBackground", bundle: .module)

        }
    }
}
