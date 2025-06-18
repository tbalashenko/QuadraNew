//
//  PlayableTextView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI

final class PlayableTextModel: ObservableObject {
    @Published var text: AttributedString = ""
    @Published var language: Language? = nil
    
    init(text: AttributedString, language: Language? = nil) {
        self.text = text
        self.language = language
    }
}

struct PlayableTextView: View {
    @ObservedObject var model: PlayableTextModel

    var body: some View {
        LeadingIconTextView(viewModel: LeadingIconTextViewModel(text: model.text)) {
            if let language = model.language {
                PlayButton(
                    text: String(model.text.characters),
                    language: language
                )
            }
        }
    }
}
