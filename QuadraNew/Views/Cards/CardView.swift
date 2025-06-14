//
//  CardView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI
import SwiftData

struct CardView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var cardService: CardService
    @EnvironmentObject var settings: SettingsService
    @ObservedObject var viewModel: CardViewModel
    @State private var showSetupCardView: Bool = false
    
    @Query var allSources: [CardSource]
    
    var body: some View {
        ZStack {
            Color.element.ignoresSafeArea()
            VStack(spacing: SizeConstants.spacing) {
                CardHeaderView(viewModel: viewModel)
                
                if viewModel.isFlippable {
                    FlippableTextView(
                        frontText: viewModel.phraseToRemember,
                        backText: viewModel.translation,
                        language: Language(viewModel.card.phraseToRememberLanguage)
                    )
                } else {
                    PlayableCardTitleTextView(
                        text: viewModel.phraseToRemember,
                        language: Language(viewModel.card.phraseToRememberLanguage)
                    )
                }
                
                if viewModel.showTranscription {
                    TranscriptionView(transcription: viewModel.transcription)
                }
                
                if viewModel.showAdditionalInfo {
                    AdditionalInfoView(viewModel: viewModel)
                }
                
                Spacer()
            }
            .frame(size: SizeConstants.cardSize)
            .background(.element)
            .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
            .southEastShadow()
            .if(viewModel.mode == .view) { content in
                content
                    .toolbar {
                        ToolbarItem {
                            SmallButton(image: "pencil.circle") {
                                showSetupCardView = true
                            }
                        }
                    }
            }
            .sheet(isPresented: $showSetupCardView) {
                NavigationStack {
                    SetupCardView(
                        viewModel: SetupCardViewModel(
                            mode: .edit,
                            sources: allSources,
                            card: viewModel.card
                        ),
                        showSetupCardView: $showSetupCardView) {_ in
                            viewModel.prepareAdditionalInfo()
                        }
                }
            }
        }
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
                phraseToRememberLanguage: "en",
                translationLanguage: "en",
                croppedImageData: UIImage(named: "testImage")?.pngData(),
            ),
            mode: .view
        )
    )
}
