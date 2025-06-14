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
    @Published var translationLanguage = [Language]()
    @Published var selectedVoices: [Language: Voice] = [:]
    @Published var selectedRatio: AspectRatio = .sixteenToNine
    @Published var selectedImageScale: ImageScale = .percent100
    @Published var showConfetti: Bool = true
    @Published var sendNotifications: Bool = false
    @Published var highlighterPalette: HighlighterPalette = .pale
    @Published var showProgress: Bool = true
    @Published var reminderTime: Date = Date()
    
    private var needSetupNotifications: Bool { settings.reminderTime != reminderTime  }
    private var cancellables = Set<AnyCancellable>()
    
    private let settings: SettingsService

    init(settings: SettingsService) {
        self.settings = settings
        self.setup()
        
        checkNotificationPermission()
        observeNotificationsSwitch()
    }
    
    func setup() {
        languagesToStudy = settings.languagesToStudy
        translationLanguage = [settings.translationLanguage]
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
        if let translationLanguage = translationLanguage.first {
            settings.translationLanguage = translationLanguage
        }
        
        for language in languagesToStudy {
            if selectedVoices[language] == nil, let defaultVoice = language.voices?.first {
                selectedVoices[language] = defaultVoice
            }
        }
        
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
    
    func checkNotificationPermission() {
        NotificationsService.shared.canSendNotifications { [weak self] canSend in
            DispatchQueue.main.async {
                self?.sendNotifications = canSend
            }
        }
    }
    
    private func observeNotificationsSwitch() {
        $sendNotifications
            .sink { [weak self] isOn in
                if isOn {
                    NotificationsService.shared.requestNotificationPermission { isEnabled, _ in
                        self?.sendNotifications = isEnabled
                    }
                } else {
                    NotificationsService.shared.removeNotifications(removeTime: true)
                }
            }
            .store(in: &cancellables)
    }
}
