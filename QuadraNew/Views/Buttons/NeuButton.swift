//
//  NeuButton.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 31/05/2025.
//

import SwiftUI

struct NeuButton: View {
    let image: String
    var buttonSize: ButtonSize = .s
    var imageSize: ImageSize = .small
    var withBackground: Bool = true
    var foregroundStyle: Color = .accentColor
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .setupButtonImage(size: imageSize)
        }
        .buttonStyle(
            NeuButtonStyle(
                foregroundColor: foregroundStyle,
                size: buttonSize,
                withBackground: withBackground,
            )
        )
    }
}

#Preview {
    NeuButton(
        image: "lightbulb.circle.fill",
        withBackground: false,
        foregroundStyle: Color.accentColor,
        action: {}
    )
    NeuButton(
        image: "plus",
        buttonSize: .m,
        imageSize: .small
    ) {  }
}


