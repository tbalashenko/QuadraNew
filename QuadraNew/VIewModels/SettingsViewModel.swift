//
//  SettingsViewModel.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 15/05/2024.
//

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    @Published var selectedVoice: Voice = .englishUs0
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
        selectedVoice = settings.voice
        selectedImageScale = settings.imageScaleSetting
        showConfetti = settings.showConfetti
        sendNotifications = settings.sendNotifications
        highlighterPalette = settings.highlighterPalette
        showProgress = settings.showProgress
        reminderTime = settings.reminderTime
        selectedRatio = settings.aspectRatio
    }

    func save() {
        settings.save(
            voice: selectedVoice,
            aspectRatio: selectedRatio,
            imageScale: selectedImageScale,
            showConfetti: showConfetti,
            highlighterPalette: highlighterPalette,
            showProgress: showProgress,
            sendNotifications: sendNotifications
        )
        
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
