//
//  TextToSpeechViewModel.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import Foundation
import AVFoundation

class TextToSpeechViewModel: NSObject, ObservableObject {
    @Published var isSpeaking: Bool = false
    private let synthesizer = AVSpeechSynthesizer()
    private let settings: SettingsService
    
    init(settings: SettingsService) {
        self.settings = settings
    }

    func speak(text: String, voice: Voice? = nil) {
        guard !synthesizer.isSpeaking else {
            stopSpeaking()
            return
        }
        
        let utterance = AVSpeechUtterance(string: text)
        let voice = voice ?? settings.voice
        
        utterance.voice = AVSpeechSynthesisVoice(identifier: voice.identifier)
        synthesizer.delegate = self
        synthesizer.speak(utterance)
        isSpeaking = true
    }

    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
}

// MARK: - AVSpeechSynthesizerDelegate
extension TextToSpeechViewModel: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
    }
}
