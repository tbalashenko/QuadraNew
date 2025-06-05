//
//  TextFieldWithFlippableButton.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 25/06/2024.
//

import SwiftUI

struct TextFieldWithFlippableButton: View {
    @Binding var text: String
    var error: String
    @State var isLoading = false
    
    var additionalButtonImage: Image? = nil
    var additionalAsyncButtonAction: (() async -> Void)? = nil
    var pasteButtonAction: ((String) -> Void)?
    
    private var showPasteButton: Bool { 
        text.isEmpty || (additionalAsyncButtonAction == nil && additionalButtonImage == nil)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("", text: $text, axis: .vertical)
                    .textFieldStyle(NeuTextFieldStyle(text: $text))
                    .onSubmit { hideKeyboard() }
                    .submitLabel(.done)
                
                if showPasteButton {
                    PasteButton { pasteButtonAction?($0) }
                } else {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    } else {
                        additionalButton()
                    }
                }
            }
            ErrorView(error: error)
        }
    }
    
    @ViewBuilder
    func additionalButton() -> some View {
        if let additionalButtonImage,
           let additionalAsyncButtonAction {
            Button {
                Task {
                    isLoading = true
                    await additionalAsyncButtonAction()
                    isLoading = false
                }
            } label: {
                additionalButtonImage
                    .smallButtonImage()
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
}

struct ErrorView: View {
    let error: String
    
    var body: some View {
        if !error.isEmpty {
            Text(error)
                .font(.footnote)
                .foregroundStyle(Color.red)
        }
    }
}

#Preview {
    TextFieldWithFlippableButton(text: .constant("Test"), error: "Test")
}
