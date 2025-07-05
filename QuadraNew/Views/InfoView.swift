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
        VStack {
            if viewModel.showHowToUseTheApp {
                NavigationLinkWithTextAndImage(destination: {
                    HowToUseTheAppView()
                }, title: TextConstants.howToUse, image: "info.circle")
            }
            
            Spacer()
                .frame(height: 16)
            
            Text(viewModel.getHint())
            
            if viewModel.isReadyToRepeat {
                PlainButtonWithImage(
                    title: TextConstants.restart,
                    image: "repeat.circle",
                    onAction: { onAction?() }
                )
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
