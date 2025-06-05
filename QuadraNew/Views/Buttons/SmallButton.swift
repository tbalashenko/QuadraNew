//
//  SmallButton.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 31/05/2025.
//

import SwiftUI

struct SmallButton: View {
    let image: String
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
        .buttonStyle(NeuButtonStyle())
    }
}


