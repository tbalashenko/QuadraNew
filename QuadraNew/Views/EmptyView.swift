//
//  EmptyView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/07/2025.
//

import SwiftUI

struct EmptyView: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
}

#Preview {
    EmptyView(text: "There is nothing to filter yet. Add at least one card")
}
