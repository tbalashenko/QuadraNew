//
//  AsyncButton.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 09/06/2025.
//

import SwiftUI

struct AsyncButton<Label: View>: View {
    let isEnabled: Bool
    let action: () async -> Void
    let label: () -> Label
    
    @State private var isRunning = false

    var body: some View {
        Button {
            isRunning = true
            Task {
                await action()
                isRunning = false
            }
        } label: {
            label()
        }
        .disabled(isRunning || !isEnabled)
    }
}
