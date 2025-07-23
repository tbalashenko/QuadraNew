//
//  Pronunciation.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 06/06/2025.
//

import SwiftUI

struct PronunciationView: View {
    let pronunciation: String
    
    var body: some View {
        Text("/\(pronunciation)/")
            .font(.system(size: 14, design: .monospaced))
            .foregroundColor(.secondary)
            .padding(.horizontal)
    }
}

#Preview {
    PronunciationView(pronunciation: "ˈæpl")
}
