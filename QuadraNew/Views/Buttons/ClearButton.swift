//
//  ClearButton.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 09/06/2025.
//

import SwiftUI

struct ClearButton<T: Clearable>: View {
    @Binding var value: T
    
    var body: some View {
        SmallButton(
            image: "multiply.circle.fill",
            withBackground: false,
            foregroundStyle: Color.secondary
        ) {
            withAnimation {
                value = T.empty
            }
        }
        .padding(.trailing, 4)
    }
}
