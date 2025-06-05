//
//  InfoView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 29/05/2025.
//

import SwiftUI
import SwiftData


struct InfoView: View {
    @Environment(\.modelContext) private var modelContext
    
    @StateObject var viewModel = InfoViewModel()
    var onAction: (() -> Void)?
    @Query private var cards: [Card]
    
    var body: some View {
        
        Group {
            if cards.isEmpty {
                HowToUseTheAppView()
            } else {
                if viewModel.isReadyToRepeat {
                    RepeatButton { onAction?() }
                } else {
                    Text(viewModel.noReadyToReviewCardsHint)
                }
            }
        }
        .onAppear {
            viewModel.setup(cards: cards)
        }
    }
}

#Preview {
    InfoView()
}
