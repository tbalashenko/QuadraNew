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
                    Button {
                        flip()
                    } label: {
                        Image(systemName: "repeat")
                            .smallButtonImage()
                            .padding()
                            .foregroundStyle(Color.gray.opacity(0.5))
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .northWestShadow()
                    }
                    .frame(size: SizeConstants.largeButtonSize)
                    .padding(.bottom, SizeConstants.screenHeight * 0.15)
                    .padding(.trailing, SizeConstants.screenWidth * 0.2)
                }
            }
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

