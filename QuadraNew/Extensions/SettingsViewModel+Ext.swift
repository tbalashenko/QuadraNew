//
//  SettingsViewModel+Ext.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 15/06/2025.
//

import Foundation
import Combine

extension SettingsViewModel {
    func observeLanguagesToStudy() {
        $languagesToStudy
            .sink { [weak self] newLanguages in
                guard let self = self else { return }
                
                let addedLanguages = newLanguages.filter { !self.previousLanguages.contains($0) }
                let removedLanguages = self.previousLanguages.filter { !newLanguages.contains($0) }
                
                for language in addedLanguages {
                    if let firstVoice = language.voices?.first {
                        self.selectedVoices[language] = firstVoice
                    }
                }
                
                for language in removedLanguages {
                    self.selectedVoices.removeValue(forKey: language)
                }
                
                self.previousLanguages = newLanguages
            }
            .store(in: &cancellables)
    }
    
    func checkNotificationPermission() {
        NotificationsService.shared.canSendNotifications { [weak self] canSend in
            DispatchQueue.main.async {
                self?.sendNotifications = canSend
            }
        }
    }
    
    func observeNotificationsSwitch() {
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
