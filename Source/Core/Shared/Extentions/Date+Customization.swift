//
//  Date+Customization.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

extension Date {
    /// Converts a Unix timestamp to a formatted 24-hour local time string.
    /// - Parameter timestamp: The Unix timestamp to convert.
    /// - Returns: A formatted string representing the 24-hour local time.
    static func timeFromUnixTimestamp(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.DateFormats.TimeFormat
        formatter.timeZone = .current
        return formatter.string(from: date)
    }
    
    static func nextHourRoundDate() throws -> Date? {
        let currentDate = Date()
        let calendar = Calendar.current

        // If the current minute is 0, return the current date as-is
        if calendar.component(.minute, from: currentDate) == 0 {
            return currentDate
        }

        // Safely calculate the next full hour
        guard let nextFullHour = calendar.date(bySetting: .minute, value: 0, of: currentDate) else {
            throw AppError.invalidTime
        }
        
        guard let roundedDate = calendar.date(
            bySetting: .hour,
            value: calendar.component(.hour, from: nextFullHour) + 1,
            of: nextFullHour
        ) else {
            throw AppError.invalidTime
        }
        
        return roundedDate
    }
    
    static func parseForecastTimestamp(_ timestamp: String?) -> Date? {
           guard let timestamp = timestamp else { return nil }
           let timestampWithUTC = timestamp + "Z"
           let isoFormatter = ISO8601DateFormatter()
           return isoFormatter.date(from: timestampWithUTC)
       }
}
