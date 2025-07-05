//
//  PlayableCardTitleTextView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI

#warning("Rename")
struct PlayableCardTitleTextView: View {
    let text: AttributedString
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            TextToSpeechPlayView(text: text.description)
            Text(text)
                .font(.title2)
                .bold()
                .padding(.vertical)
                .padding(.trailing)
            Spacer()
        }
        .background(Color.element)
    }
}

#Preview {
    PlayableCardTitleTextView(text: "Long, long text")
}
