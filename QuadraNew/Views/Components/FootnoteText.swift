//
//  FootnoteText.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 11/06/2025.
//

import SwiftUI

struct FootnoteText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.secondary)
            .font(.footnote)
    }
}
