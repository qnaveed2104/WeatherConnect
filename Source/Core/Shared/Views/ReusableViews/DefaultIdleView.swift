//
//  DefaultIdleView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct DefaultIdleView: View {
    var body: some View {
        Text("Idle View")
            .font(.largeTitle)
            .font(.headline)
            .foregroundColor(.gray)
            .padding()
            .background(AppColors.primaryBackground.color)

    }
    
}

#Preview {
    DefaultIdleView()
}
