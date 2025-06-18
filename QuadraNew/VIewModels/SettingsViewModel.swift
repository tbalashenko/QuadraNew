//
//  SettingsViewModel.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 15/05/2024.
//

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    @Published var languagesToStudy = [Language]()
    @Published var selectedVoices: [Language: Voice] = [:]
    @Published var selectedRatio: AspectRatio = .sixteenToNine
    @Published var selectedImageScale: ImageScale = .percent100
    @Published var showConfetti: Bool = true
    @Published var sendNotifications: Bool = false
    @Published var highlighterPalette: HighlighterPalette = .pale
    @Published var showProgress: Bool = true
    @Published var reminderTime: Date = Date()
    var showVoicesSection: Bool { !selectedVoices.isEmpty }
    
    var previousLanguages: [Language] = []
    private var needSetupNotifications: Bool { settings.reminderTime != reminderTime  }
    var cancellables = Set<AnyCancellable>()
    
    private let settings: SettingsService

    init(settings: SettingsService) {
        self.settings = settings
        self.setup()
        
        checkNotificationPermission()
        observeNotificationsSwitch()
        observeLanguagesToStudy()
    }
    
    func setup() {
        if let languagesToStudy = settings.languagesToStudy {
            self.languagesToStudy = languagesToStudy
            self.previousLanguages = languagesToStudy
        }
        
        selectedVoices = settings.voices
        selectedImageScale = settings.imageScaleSetting
        showConfetti = settings.showConfetti
        sendNotifications = settings.sendNotifications
        highlighterPalette = settings.highlighterPalette
        showProgress = settings.showProgress
        reminderTime = settings.reminderTime
        selectedRatio = settings.aspectRatio
    }

    func save() {
        settings.languagesToStudy = languagesToStudy
        settings.voices = selectedVoices
        settings.aspectRatio = selectedRatio
        settings.imageScaleSetting = selectedImageScale
        settings.showConfetti = showConfetti
        settings.highlighterPalette = highlighterPalette
        settings.showProgress = showProgress
        settings.sendNotifications = sendNotifications
        
        if needSetupNotifications {
            NotificationsService.shared.scheduleNotifications(time: reminderTime)
        }
    }
}
