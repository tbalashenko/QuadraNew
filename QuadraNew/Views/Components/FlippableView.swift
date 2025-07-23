//
//  FlippableView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI

struct FlippableView<Front: View, Back: View>: View {
    @State var isFlipped: Bool = false
    @State private var flashcardRotation = 0.0
    @State private var contentRotation = 0.0

    let front: Front
    let back: Back

    init(
        @ViewBuilder front: () -> Front,
        @ViewBuilder back: () -> Back
    ) {
        self.front = front()
        self.back = back()
    }

    var body: some View {
        ZStack {
            ZStack {
                front
                    .opacity(isFlipped ? 0 : 1)
                back
                    .opacity(isFlipped ? 1 : 0)
            }
            .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
            .padding()

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    IconCircleButton(systemName: "repeat", size: .s) { flip() }
                }
            }
            .offset(x: SizeConstants.cardWidth / -4, y: SizeConstants.cardHeight / -4)
        }
    }
    
    private func flip(animationTime: Double = 0.5) {
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += 180
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += 180
            isFlipped.toggle()
        }
    }
}

struct IconCircleButton: View {
    let systemName: String
    let size: ButtonSize
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(size: size.size)
                .foregroundStyle(Color.gray.opacity(0.5))
                .padding()
                .background(Color.element)
                .clipShape(Circle())
                .northWestShadow()
        }
    }
}


#Preview {
    FlippableView(front: {
        CardFrontView(viewModel: CardViewModel(card: MockData.cards.first!, mode: .view))
    }, back: {
        CardBackView(viewModel: CardViewModel(card: MockData.cards.first!, mode: .view))
    })
    .environmentObject(SizeConstants(settings: SettingsService()))
}
