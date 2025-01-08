//
//  ThemeFonts.swift
//  WeatherCore
//
//  Created by Qazi on 07/01/2025.
//

import SwiftUI
// Define an actor to manage thread-safe access to registered fonts
actor FontRegistry {
    private var registeredFonts: Set<String> = []

    // Check if the font is registered
    func isFontRegistered(_ fontName: String) -> Bool {
        return registeredFonts.contains(fontName)
    }

    // Register the font
    func registerFont(_ fontName: String) {
        registeredFonts.insert(fontName)
    }
}

enum ThemeFonts {
    
    enum FontType {
        case heading1, heading2, title, textRegular, label, customFont
    }
    
    // Create an instance of the actor to manage font registration
        private static let fontRegistry = FontRegistry()

        // Font loading function from the package's bundle
        static func fontFromBundle(named fontName: String, size: CGFloat) -> Font {
            let bundle = Bundle.module // Replace with your package's bundle if necessary

            Task {
                let isRegistered = await fontRegistry.isFontRegistered(fontName)
                if isRegistered {
//                    print("Font \(fontName) already registered")
                } else {
                    // Register the font with CoreGraphics
                    guard let fontURL = bundle.url(forResource: fontName, withExtension: "otf") else {
                        fatalError("Font \(fontName) not found in bundle")
                    }
                    
                    guard let fontData = try? Data(contentsOf: fontURL),
                          let provider = CGDataProvider(data: fontData as CFData),
                          let font = CGFont(provider) else {
                        fatalError("Failed to load font \(fontName)")
                    }
                    
                    // Register the font
                    CTFontManagerRegisterGraphicsFont(font, nil)
                    
                    // Register the font in the actor
                    await fontRegistry.registerFont(fontName)
                }
            }

            return Font.custom(fontName, size: size)
        }
    

    static func h1() -> Font { fontFromBundle(named: AppConstants.FontNames.bold, size: 28) }
    static func h2() -> Font { fontFromBundle(named: AppConstants.FontNames.bold, size: 20) }
    static func title() -> Font { fontFromBundle(named: AppConstants.FontNames.bold, size: 16) }
    static func textRegular() -> Font { fontFromBundle(named: AppConstants.FontNames.medium, size: 16) }
    static func label() -> Font { fontFromBundle(named: AppConstants.FontNames.medium, size: 12) }
    static func customFont() -> Font { fontFromBundle(named: AppConstants.FontNames.medium, size: 12) }

    static func fontStyle(for type: FontType) -> (font: Font, lineSpacing: CGFloat) {
        switch type {
        case .heading1:
            return (font: h1(), lineSpacing: 36)
        case .heading2:
            return (font: h2(), lineSpacing: 28)
        case .title:
            return (font: title(), lineSpacing: 24)
        case .textRegular:
            return (font: textRegular(), lineSpacing: 24)
        case .label:
            return (font: label(), lineSpacing: 18)
        case .customFont:
            return (font: label(), lineSpacing: 0)

        }
    }
}
