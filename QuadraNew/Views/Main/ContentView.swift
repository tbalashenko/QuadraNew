//
//  ContentView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI
import SwiftData
import Combine

struct ContentView: View {
    @EnvironmentObject var settings: SettingsService
    @StateObject private var viewModel = ContentViewModel()
    @State private var showSetupCardView: Bool = false
    @State private var isLoading: Bool = false
    
    @Query private var allCards: [Card]
    @Query private var allSources: [CardSource]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.element
                    .ignoresSafeArea()
                ForEach(viewModel.readyToRepeatCards) { card in
                    SwipeableCardView(card: card, viewModel: viewModel)
                }
                
                if viewModel.showInfoView {
                    InfoView {
                        viewModel.setCards(allCards)
                    }
                }
            }
            .overlay { ConfettiView(isPresented: $viewModel.showConfetti) }
            .overlay { SkeletonCardView(isPresented: $isLoading) }
            .onAppear {
                if allCards.isEmpty {
                    if !viewModel.readyToRepeatCards.isEmpty {
                        setCards(withAnimation: false)
                    }
                } else {
                    setCards()
                }
            }
            .onDisappear {
                viewModel.showConfetti = false
            }
            .toolbar {
                ToolbarItem {
                    SmallButton(
                        image: "plus.circle.fill",
                        withBackground: false
                    ) {
                        showSetupCardView = true
                    }
                }
            }
            .toolbar {
                if !viewModel.showInfoView, settings.showProgress {
                    ToolbarItem(placement: .topBarLeading) {
                        ProgressView(
                            value: viewModel.progress,
                            label: { Text("") },
                            currentValueLabel: { Text(viewModel.progressViewLabel) }
                        )
                        .progressViewStyle(.linear)
                        .frame(width: SizeConstants.screenWidth / 2)
                    }
                }
            }
            .sheet(isPresented: $showSetupCardView) {
                NavigationStack {
                    SetupCardView(
                        viewModel: SetupCardViewModel(
                            mode: .create,
                            sources: allSources
                        ),
                        showSetupCardView: $showSetupCardView
                    ) { cardWasAdded in
                        if cardWasAdded { setCards() }
                    }
                }
            }
        }
    }
    
    private func setCards(withAnimation: Bool = true) {
        if withAnimation {
            isLoading = true
        }
        viewModel.setCards(allCards)
        if withAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                isLoading = false
            }
        }
    }
}

