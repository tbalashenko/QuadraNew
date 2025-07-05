//
//  AppConfiguration.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 19/05/2025.
//


import Foundation

class AppConfiguration {
    static func configure() {
        NotificationsService.shared.scheduleNotifications()
    }
}