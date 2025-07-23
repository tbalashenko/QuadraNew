//
//  PasteButton.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 24/06/2024.
//

import SwiftUI

struct PasteButton: View {
    var action: ((String) -> Void)?

    var body: some View {
        NeuButton(image: "doc.on.clipboard", withBackground: false) {
            Task {
                await MainActor.run {
                    action?(UIPasteboard.general.string ?? "")
                }
            }
        }
        
    }
}

#Preview {
    PasteButton()
}
