//
//  String+Formating.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//
import Foundation
extension String {
    func getlocalTime() -> String? {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

            if let date = inputFormatter.date(from: self) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "HH:mm"
                return outputFormatter.string(from: date)
            }
            return nil
        }
}
