//
//  EditableCardView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 17/06/2025.
//

import SwiftUI
import SwiftData

struct EditableCardView: View {
    @ObservedObject var viewModel: CardViewModel
    @State private var showSetupCardView: Bool = false
    @Query var allSources: [CardSource]
    
    var body: some View {
        ZStack {
            Color.element.ignoresSafeArea()
            FlippableCardView(viewModel: viewModel)
                .toolbar {
                    ToolbarItem {
                        SmallButton(
                            image: "pencil.circle",
                            withBackground: true
                        ) {
                            showSetupCardView = true
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
