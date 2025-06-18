//
//  SmallButton.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 31/05/2025.
//

import SwiftUI

struct SmallButton: View {
    let image: String
    var withBackground: Bool
    var foregroundStyle: Color = .accentColor
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: image)
                .smallButtonImage()
                .foregroundStyle(foregroundStyle)
        }
        .buttonStyle(
            NeuButtonStyle(
                size: SizeConstants.smallButtonSize,
                withBackground: withBackground
            )
        )
    }
}

#Preview {
    SmallButton(
        image: "lightbulb.circle.fill",
        withBackground: false,
        foregroundStyle: Color.accentColor,
        action: {}
    )
}


