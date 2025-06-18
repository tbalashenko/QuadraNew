//
//  CardView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 17/06/2025.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: SizeConstants.spacing) {
            content
            Spacer()
        }
        .frame(size: SizeConstants.cardSize)
        .background(.element)
        .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
        .southEastShadow()
    }
}
