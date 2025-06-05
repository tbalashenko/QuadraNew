//
//  PlainButtonWithImage.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 29/05/2025.
//

import SwiftUI

struct PlainButtonWithImage: View {
    var title: String
    var image: String
    var onAction: (() -> Void)?
    
    var body: some View {
        Button {
            onAction?()
        } label: {
            Label(title, systemImage: image)
        }
        .buttonStyle(NeuButtonStyle(size: SizeConstants.plainButtonSize))
    }
}
