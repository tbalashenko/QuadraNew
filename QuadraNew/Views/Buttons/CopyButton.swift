//
//  CopyButton.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 17/06/2024.
//

import SwiftUI

struct CopyButton: View {
    var text: String
    var action: (() -> Void)?

    var body: some View {
        NeuButton(image: "doc.on.doc") {
            UIPasteboard.general.string = text
            action?()
        }
    }
}

 #Preview {
     CopyButton(text: "Test")
 }
