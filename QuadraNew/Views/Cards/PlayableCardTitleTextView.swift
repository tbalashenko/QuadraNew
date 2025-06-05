//
//  PlayableCardTitleTextView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI

#warning("Rename")
struct PlayableCardTitleTextView: View {
    @EnvironmentObject var settings: SettingsService
    let text: AttributedString
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            TextToSpeechPlayView(viewModel: TextToSpeechViewModel(settings: settings), text: String(text.characters))
                .environmentObject(settings)
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
