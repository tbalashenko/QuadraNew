//
//  SwipeableCardView.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 19/05/2025.
//

import SwiftUI

struct SwipeableCardView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var cardService: CardService
    
    @State private var xOffset: CGFloat = .zero
    @State private var yOffset: CGFloat = .zero
    @State private var degrees: Double = 0
    
    @StateObject private var cardViewModel: CardViewModel
    @ObservedObject private var viewModel: ContentViewModel
    
    @Bindable var card: Card
    
    init(card: Card, viewModel: ContentViewModel) {
        _cardViewModel = StateObject(wrappedValue: CardViewModel(card: card, mode: .repetition))
        self.card = card
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            FlippableCardView(viewModel: cardViewModel)
            SwipeIndicatorView(xOffset: $xOffset)
        }
        .rotationEffect(.degrees(degrees))
        .offset(x: xOffset, y: yOffset)
        .animation(.snappy, value: xOffset)
        .animation(.snappy, value: yOffset)
        .gesture(
            DragGesture(minimumDistance: 20)
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
        )
    }
}

#Preview {
    SwipeableCardView(card: MockData.cards.first!, viewModel: ContentViewModel())
        .environmentObject(SizeConstants(settings: SettingsService()))
        .environmentObject(CardService())
}

private extension SwipeableCardView {
    private func returnToCenter() {
        xOffset = 0
        yOffset = 0
        degrees = 0
    }
    
    private func swipeRight() {
        withAnimation(.snappy(duration: 1)) {
            xOffset = 500
            degrees = 12
        } completion: {
            viewModel.swipeCard(card: card, cardService: cardService, context: context, swipeSide: .right)
        }
    }
    
    private func swipeLeft() {
        withAnimation(.snappy(duration: 1)) {
            xOffset = -500
            degrees = -12
        } completion: {
            viewModel.swipeCard(card: card, cardService: cardService, context: context, swipeSide: .left)
        }
    }
}

private extension SwipeableCardView {
    private func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        yOffset = value.translation.height
        degrees = Double(value.translation.width/25)
    }
    
    private func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        if abs(width) <= SizeConstants.screenCutOff {
            returnToCenter()
            return
        }
        
        if width >= SizeConstants.screenCutOff {
            swipeRight()
        } else {
            swipeLeft()
        }
    }
}
