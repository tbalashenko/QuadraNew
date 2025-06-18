//
//  NeuTextFIeldStyle.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 20/03/2024.
//

import SwiftUI

struct NeuTextFieldStyle: TextFieldStyle {
    @Binding var text: String
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .lineLimit(5)
            .padding(.leading, SizeConstants.mediumSpacing + 4)
            .padding(.trailing, SizeConstants.bigSpacing)
            .padding(.vertical, SizeConstants.spacing)
            .frame(minHeight: 36)
            .background(
                Color.element
                    .shadow(.inner(color: .highlight, radius: 3, x: -3, y: -3))
                    .shadow(.inner(color: .shadow, radius: 3, x: 3, y: 3))
            )
            .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
            .overlay(alignment: .trailing) {
                if !text.isEmpty {
                    ClearButton(value: $text)
                }
            }
    }
}

#Preview {
    @Previewable
    @State var text2: AttributedString = "fferfrf"
    
    VStack {
        Spacer()
        HighlightableTextView(text: $text2, placeholder: "Placeholder", error: "Test")
            .environmentObject(SettingsService())
        TextField("Test", text: .constant("Test"), axis: .vertical)
            .textFieldStyle(NeuTextFieldStyle(text: .constant("Test")))
        TextField("Test", text: .constant("Test"), axis: .vertical)
            .textFieldStyle(NeuTextFieldStyle(text: .constant("Test")))
        TextField("Test", text: .constant("Test"))
            .textFieldStyle(NeuTextFieldStyle(text: .constant("Test")))
        Spacer()
    }
}
