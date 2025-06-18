//
//  Date+Ext.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import Foundation

extension Date {
    func formatDate(
        dateStyle: DateFormatter.Style = .medium,
        timeStyle: DateFormatter.Style = .short
    ) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    func daysAgo(from date: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day], from: date, to: now)
        return components.day ?? 0
    }
    
    func formattedForStats() -> Date? {
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)

        return calendar.date(from: DateComponents(year: year, month: month, day: day))
    }
    
    func prepareTagTitle() -> String {
        let calendar = Calendar.current

        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let formattedMonth = String(format: "%02d", month)

        return "#\(year)-\(formattedMonth)"
    }
}
