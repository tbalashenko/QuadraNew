//
//  SettingsManager.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 09/04/2024.
//

import Foundation
import Combine

final class SettingsService: ObservableObject {
    @Published var languagesToStudy: [Language]? = {
        let languages = UserDefaults.standard.stringArray(forKey: UserDefaultsKeys.languagesToStudy)
        return languages?.compactMap { Language(rawValue: $0) }
    }() {
        didSet {
            guard let languagesToStudy else { return }
            
            UserDefaults.standard.set(languagesToStudy.map { $0.rawValue }, forKey: UserDefaultsKeys.languagesToStudy)
        }
    }
    
    @Published var voices: [Language: Voice] = {
        guard let savedDict = UserDefaults.standard.dictionary(forKey: UserDefaultsKeys.selectedVoices) as? [String: String] else { return [:] }
        
        var loadedVoices: [Language: Voice] = [:]
        for (languageRaw, voiceRaw) in savedDict {
            guard let language = Language(rawValue: languageRaw), let voice = Voice(rawValue: voiceRaw) else { continue }
            
            loadedVoices[language] = Voice(rawValue: voiceRaw)
        }
        return loadedVoices
    }() {
        didSet {
            let dictToSave = voices.reduce(into: [String: String]()) { result, pair in
                let (language, voice) = pair
                result[language.rawValue] = voice.identifier
            }
            UserDefaults.standard.set(dictToSave, forKey: UserDefaultsKeys.selectedVoices)
        }
    }
    
    
    @Published var aspectRatio: AspectRatio = {
        let rawValue = UserDefaultsManager.stringForKey(UserDefaultsKeys.aspectRatio) ?? AspectRatio.sixteenToNine.rawValue
        return AspectRatio(rawValue: rawValue) ?? .sixteenToNine
    }() {
        didSet {
            UserDefaultsManager.saveObject(aspectRatio.rawValue, forKey: UserDefaultsKeys.aspectRatio)
        }
    }
    
    @Published var imageScaleSetting: ImageScale = {
        let rawValue = UserDefaultsManager.doubleForKey(UserDefaultsKeys.imageScale) ?? ImageScale.percent100.rawValue
        return ImageScale(rawValue: rawValue) ?? .percent100
    }() {
        didSet {
            UserDefaultsManager.saveObject(imageScaleSetting.rawValue, forKey: UserDefaultsKeys.imageScale)
        }
    }
    
    @Published var showConfetti: Bool = UserDefaultsManager.boolForKey(UserDefaultsKeys.showConfetti) ?? true {
        didSet {
            UserDefaultsManager.saveObject(showConfetti, forKey: UserDefaultsKeys.showConfetti)
        }
    }
    
    @Published var highlighterPalette: HighlighterPalette = {
        let rawValue = UserDefaultsManager.integerForKey(UserDefaultsKeys.highlighterPalette) ?? 0
        return HighlighterPalette(rawValue: rawValue) ?? .pale
    }() {
        didSet {
            UserDefaultsManager.saveObject(highlighterPalette.rawValue, forKey: UserDefaultsKeys.highlighterPalette)
        }
    }
    
    @Published var showProgress: Bool = UserDefaultsManager.boolForKey(UserDefaultsKeys.showProgress) ?? true {
        didSet {
            UserDefaultsManager.saveObject(showProgress, forKey: UserDefaultsKeys.showProgress)
        }
    }
    
    @Published var reminderTime: Date =  UserDefaultsManager.dateForKey(UserDefaultsKeys.reminderTime) ?? Date() {
        didSet {
            UserDefaultsManager.saveObject(reminderTime, forKey: UserDefaultsKeys.reminderTime)
        }
    }
    
    @Published var sendNotifications: Bool = UserDefaultsManager.boolForKey(UserDefaultsKeys.sendNotifications) ?? true {
        didSet {
            UserDefaultsManager.saveObject(sendNotifications, forKey: UserDefaultsKeys.sendNotifications)
        }
    }
}
