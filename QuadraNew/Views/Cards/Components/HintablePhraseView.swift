//
//  HintablePhraseView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 16/06/2025.
//

import SwiftUI

struct HintablePhraseView: View {
    @ObservedObject var viewModel: CardViewModel
    @State private var isHintPressed = false

    var body: some View {
        LeadingIconTextView(
            viewModel: LeadingIconTextViewModel(
                text: viewModel.currentHintText
            )
        ) {
            hintButton
        }
    }

    private var hintButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                isHintPressed = true
                viewModel.nextHintStage()
            }

            withAnimation(.spring().delay(0.2)) {
                isHintPressed = false
            }
        } label: {
            Image(systemName: "lightbulb.min.fill")
                .smallButtonImage()
                .foregroundStyle(viewModel.isFinalHintStage ? .gray.opacity(0.5) : .yellow)
                .opacity(isHintPressed ? 1 : 0.5)
                .scaleEffect(isHintPressed ? 1.4 : 1.0)
                .northWestShadow()
                .shadow(
                    color: .yellow.opacity(isHintPressed ? 0.7 : 0.2),
                    radius: isHintPressed ? 8 : 4
                )
        }
        .disabled(viewModel.isFinalHintStage)
    }
}




#Preview {
    HintablePhraseView(
        viewModel: CardViewModel(
            card: Card(
                phraseToRemember: "PhraseToRemember What is your name? What if it's longer than I expected. What is your name? What if it's longer than I expected. What is your name? What if it's longer than I expected. What is your name? What if it's longer than I expected",
                translation: "Translation. What is your name? What if it's longer than I expected. What is your name? What if it's longer than I expected What is your name? What if it's longer than I expected",
                archiveTag: ArchiveTag(),
                cardSources: [],
                definition: "Definition. What is your name? What if it's longer than I expected. What is your name? What if it's longer than I expected What is your name? What if it's longer than I expected",
                phraseToRememberLanguage: Language.english.rawValue,
                imageData: UIImage(named: "testImage")?.pngData(),
                croppedImageData: UIImage(named: "testImage")?.pngData(),
            ), mode: .view
        )
    )
    .environmentObject(SettingsService())
}
