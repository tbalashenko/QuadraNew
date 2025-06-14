//
//  VoicePickerView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 15/05/2024.
//

import SwiftUI

struct VoicePickerView: View {
    @EnvironmentObject var settings: SettingsService
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        ForEach(viewModel.languagesToStudy.filter { $0.voices?.isEmpty == false }) { language in
            if let voices = language.voices {
                Picker(
                    language.title,
                    selection: Binding(
                        get: { viewModel.selectedVoices[language] ?? voices.first! },
                        set: { viewModel.selectedVoices[language] = $0 }
                    )) {
                        ForEach(voices, id: \.self) { voice in
                            Text((voice.name))
                                .tag(voice)
                        }
                    }
                    .pickerStyle(.menu)
                LabeledContent(TextConstants.sampleText) {
                    HStack {
                        Text(language.samplePhrase)
                        if let voice = viewModel.selectedVoices[language] {
                            TextToSpeechPlayView(
                                viewModel: TextToSpeechViewModel(settings: settings),
                                text: language.samplePhrase,
                                language: language,
                                voice: voice
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    //VoicePickerView(viewModel: SettingsViewModel(settings: SettingsService()))
}
