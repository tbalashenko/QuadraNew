//
//  TextToSpeechPlayView.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

struct TextToSpeechPlayView: View {
    @EnvironmentObject var settings: SettingsService
    @StateObject var viewModel: TextToSpeechViewModel
    var buttonSize: Size = .small
    var text: String
    var language: Language
    var voice: Voice? = nil
    
    init(
        viewModel: TextToSpeechViewModel,
        text: String,
        language: Language,
        buttonSize: Size = .small,
        voice: Voice? = nil) {
            _viewModel = StateObject(wrappedValue: viewModel)
            self.buttonSize = buttonSize
            self.text = text
            self.voice = voice
            self.language = language
        }

    var body: some View {
        SmallButton(image: viewModel.isSpeaking ? "stop.circle" : "play.circle") {
            viewModel.speak(
                text: text,
                language: language,
                voice: voice
            )
        }
        .padding(SizeConstants.spacing)
        .buttonStyle(NeuButtonStyle())
    }
}

extension TextToSpeechPlayView {
    enum Size {
        case small, medium

        var size: CGSize {
            switch self {
                case .small:
                    CGSize(width: 12, height: 12)
                case .medium:
                    CGSize(width: 22, height: 22)
            }
        }
    }
}

#Preview {
    //TextToSpeechPlayView(text: "Long, long text")
}
