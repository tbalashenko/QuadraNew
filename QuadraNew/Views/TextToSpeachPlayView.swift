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
    var voice: Voice? = nil
    
    init(viewModel: TextToSpeechViewModel, buttonSize: Size = .small, text: String, voice: Voice? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.buttonSize = buttonSize
        self.text = text
        self.voice = voice
    }

    var body: some View {
        SmallButton(image: viewModel.isSpeaking ? "stop.circle" : "play.circle") {
            viewModel.speak(
                text: text,
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
