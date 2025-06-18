//
//  TranscriptionView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 06/06/2025.
//

import SwiftUI

struct TranscriptionView: View {
    let transcription: String
    
    var body: some View {
        Text("/\(transcription)/")
            .font(.system(size: 14, design: .monospaced))
            .foregroundColor(.secondary)
            .padding(.horizontal)
    }
}

#Preview {
    TranscriptionView(transcription: "ˈæpl")
}
