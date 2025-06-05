//
//  SettingsManager.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 09/04/2024.
//

import Foundation
import Combine

final class SettingsService: ObservableObject {
    @Published var voice: Voice = {
        let identifier = UserDefaultsManager.stringForKey(UserDefaultsKeys.textToSpeechVoiceIdentifier) ?? Voice.englishUs0.identifier
        return Voice(identifier: identifier)
    }() {
        didSet(voice) {
            UserDefaultsManager.saveObject(voice.identifier, forKey: UserDefaultsKeys.textToSpeechVoiceIdentifier)
        }
    }
    
    @Published var aspectRatio: AspectRatio = {
        let rawValue = UserDefaultsManager.stringForKey(UserDefaultsKeys.aspectRatio) ?? AspectRatio.sixteenToNine.rawValue
        return AspectRatio(rawValue: rawValue) ?? .sixteenToNine
    }() {
        didSet(aspectRatio) {
            UserDefaultsManager.saveObject(aspectRatio.rawValue, forKey: UserDefaultsKeys.aspectRatio)
        }
    }
    
    @Published var imageScale: ImageScale = {
        let rawValue = UserDefaultsManager.doubleForKey(UserDefaultsKeys.imageScale) ?? ImageScale.percent100.rawValue
        return ImageScale(rawValue: rawValue) ?? .percent100
    }() {
        didSet(imageScale) {
            UserDefaultsManager.saveObject(imageScale.rawValue, forKey: UserDefaultsKeys.imageScale)
        }
    }
    
    @Published var showConfetti: Bool = UserDefaultsManager.boolForKey(UserDefaultsKeys.showConfetti) ?? true {
        didSet(showConfetti) {
            UserDefaultsManager.saveObject(showConfetti, forKey: UserDefaultsKeys.showConfetti)
        }
    }
    
    @Published var highlighterPalette: HighlighterPalette = {
        let rawValue = UserDefaultsManager.integerForKey(UserDefaultsKeys.highlighterPalette) ?? 0
        return HighlighterPalette(rawValue: rawValue) ?? .pale
    }() {
        didSet(highlighterPalette) {
            UserDefaultsManager.saveObject(highlighterPalette.rawValue, forKey: UserDefaultsKeys.highlighterPalette)
        }
    }
    
    @Published var showProgress: Bool = UserDefaultsManager.boolForKey(UserDefaultsKeys.showProgress) ?? true {
        didSet(showProgress) {
            UserDefaultsManager.saveObject(showProgress, forKey: UserDefaultsKeys.showProgress)
        }
    }
    
    @Published var reminderTime: Date =  UserDefaultsManager.dateForKey(UserDefaultsKeys.reminderTime) ?? Date() {
        didSet(reminderTime) {
            UserDefaultsManager.saveObject(reminderTime, forKey: UserDefaultsKeys.reminderTime)
        }
    }
    
    @Published var sendNotifications: Bool = UserDefaultsManager.boolForKey(UserDefaultsKeys.sendNotifications) ?? true {
        didSet(sendNotifications) {
            UserDefaultsManager.saveObject(sendNotifications, forKey: UserDefaultsKeys.sendNotifications)
        }
    }

    func save(
        voice: Voice,
        aspectRatio: AspectRatio,
        imageScale: ImageScale,
        showConfetti: Bool,
        highlighterPalette: HighlighterPalette,
        showProgress: Bool,
        sendNotifications: Bool
    ) {
        self.voice = voice
        self.aspectRatio = aspectRatio
        self.imageScale = imageScale
        self.showConfetti = showConfetti
        self.highlighterPalette = highlighterPalette
        self.showProgress = showProgress
        self.sendNotifications = sendNotifications
    }
}
