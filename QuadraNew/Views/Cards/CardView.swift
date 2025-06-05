//
//  CardView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        VStack(spacing: SizeConstants.spacing) {
            CardHeaderView(viewModel: viewModel)
            
            if viewModel.isFlippable {
                FlippableTextView(
                    frontText: viewModel.phraseToRemember,
                    backText: viewModel.translation
                )
            } else {
                PlayableCardTitleTextView(text: viewModel.phraseToRemember)
            }
            
            if viewModel.showTranscription {
                TranscriptionView(transcription: viewModel.transcription)
            }
                
            
            Spacer()
        }
        .frame(size: SizeConstants.cardSize)
        .background(.element)
        .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
        .southEastShadow()
    }
}

#Preview {
//    CardView(
//        viewModel: CardViewModel(
//            card: Card(
//                phraseToRemember: "What is your name? What if it's longer than I expected",
//                croppedImage: UIImage(named: "testImage")?.pngData())
//        )
//    )
//    CardView(
//        viewModel: CardViewModel(
//            card: Card(
//                phraseToRemember: "What is your name? What is your name? What is your name? What is your name? What if it's longer than I expected",
//                translation: "What is your translation? What if it's longer than I expected"
//            )
//        )
//    )
    CardView(
        viewModel: CardViewModel(
            card: Card(
                phraseToRemember: "What is your name? What is your name? What is your name? What is your name? What if it's longer than I expected",
                archiveTag: ArchiveTag(),
                cardSources: [],
                translation: "What is your translation? What if it's longer than I expected",
                transcription: "What is your transcription? What if it's longer than I expected",
                croppedImageData: UIImage(named: "testImage")?.pngData()
            )
        )
    )
}

#warning("")
struct TranscriptionView: View {
    let transcription: String
    
    var body: some View {
        Text("[\(transcription)]")
            .font(.title3)
            .padding(.horizontal)
    }
}
        
