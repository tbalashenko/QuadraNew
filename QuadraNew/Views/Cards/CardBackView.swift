//
//  CardBackView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 17/06/2025.
//

import SwiftUI

struct CardBackView: View {
    @EnvironmentObject var sizeConstants: SizeConstants
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        CardView {
            Rectangle()
                .foregroundColor(.element)
                .frame(size: sizeConstants.imageSize)
            PlayableTextView(
                model: PlayableTextModel(
                    text: viewModel.phraseToRemember,
                    language: viewModel.phraseToRememberLanguage
                )
            )
            if viewModel.showPronunciation {
                PronunciationView(pronunciation: viewModel.pronunciation)
            }
        }
    }
}
