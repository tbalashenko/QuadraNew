//
//  CardFrontView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI
import SwiftData

struct CardFrontView: View {
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        CardView {
            CardHeaderView(viewModel: viewModel)
            
            switch viewModel.mode {
                case .repetition:
                    HintablePhraseView(viewModel: viewModel)
                case .view:
                    LeadingIconTextView(
                        viewModel: LeadingIconTextViewModel(
                            text: viewModel.translation
                                .applyingFont(.subheadline.italic())
                        )
                    ) {
                        NeuButton(image: "translate", withBackground: false) { }
                    }
                    
                    PlayableTextView(
                        model: PlayableTextModel(
                            text: viewModel.definition
                                .applyingFont(.headline)
                        )
                    )
                    .padding(.bottom)
            }
            
            if viewModel.showAdditionalInfo {
                AdditionalInfoView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    CardFrontView(
        viewModel: CardViewModel(
            card: MockData.cards.first!,
            mode: .view
        )
    )
    .environmentObject(SizeConstants(settings: SettingsService()))
}
