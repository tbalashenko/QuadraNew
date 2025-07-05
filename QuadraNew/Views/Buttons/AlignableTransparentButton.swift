//
//  AlignableTransparentButton.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

struct AlignableTransparentButton<Content: View>: View {
    var alignment: Alignment
    var content: () -> Content
    var action: (() -> Void)?

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: alignment) {
                Button {
                    action?()
                } label: {
                    content()
                }
                .buttonStyle(.transparentButtonStyle)
                .padding(SizeConstants.buttonPadding)
            }
            .frame(size: geometry.size, alignment: alignment)
        }
    }
}


#Preview {
    ZStack {
        Rectangle()
        AlignableTransparentButton(
            alignment: .topLeading) {
                Image(systemName: "trash")
                    .smallButtonImage()
            } action: {
                print("trash")
            }
    }
    .frame(size: CGSize(width: 300, height: 300))
}
