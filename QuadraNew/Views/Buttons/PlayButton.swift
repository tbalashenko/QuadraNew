//
//  PlayButton.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

struct PlayButton: View {
    @EnvironmentObject var settings: SettingsService
    @StateObject var viewModel = TextToSpeechViewModel()
    
    var text: String
    var language: Language
    var voice: Voice? = nil
    
    var body: some View {
        SmallButton(
            image: viewModel.isSpeaking ? "stop.circle" : "play.circle",
            withBackground: true
        ) {
            viewModel.speak(
                text: text,
                language: language,
                settings: settings,
                voice: voice
            )
        }
    }
}

#Preview {
    PlayButton(
        text: "Long, long text",
        language: Language.english,
        voice: Voice.englishUs0
    )
    .environmentObject(SettingsService())
}
