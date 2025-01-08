//
//  DefaultEmptyView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct DefaultEmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("No information available")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            Spacer()
        }
        .background(AppColors.primaryBackground.color)

    }
}

#Preview {
    DefaultEmptyView()
}
