//
//  ArrowView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 31/05/2025.
//

import SwiftUI

struct ArrowView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "arrow.turn.up.left")
                .resizable()
                .frame(size: CGSize(width: 44, height: 44))
                .opacity(0.1)
            
            Spacer(minLength: SizeConstants.dummyCardSize.width + 64)
            
            Image(systemName: "arrow.turn.up.right")
                .resizable()
                .frame(size: CGSize(width: 44, height: 44))
                .opacity(0.1)
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ArrowView()
}
