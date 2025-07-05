//
//  AlignableView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import SwiftUI

struct AlignableView<Content: View>: View {
    var alignment: Alignment
    var content: () -> Content
    var action: (() -> Void)?

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: alignment) {
                content()
                    .padding(SizeConstants.buttonPadding)
            }
            .frame(size: geometry.size, alignment: alignment)
        }
    }
}
