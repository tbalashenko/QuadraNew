//
//  FlippableTextView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI

struct FlippableTextView: View {
    @State private var isFlipped = false
    @State var contentRotation = 0.0
    @State var flashcardRotation = 0.0
    
    let frontText: AttributedString
    let backText: AttributedString

    var body: some View {
        PlayableCardTitleTextView(text: isFlipped ? backText : frontText)
            .background(Color.element)
            .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
                flipFlashcard()
            }
    }

    private func flipFlashcard(animationTime: Double = 0.5) {
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += 180
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += 180
            isFlipped.toggle()
        }
    }
}
