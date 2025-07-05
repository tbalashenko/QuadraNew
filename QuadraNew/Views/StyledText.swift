//
//  StyledText.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

struct StyledText: View {
    let description: String
    let value: String

    var body: some View {
        HStack {
            Text(description)
                .bold()
                .font(.system(size: 16))
            Text(value)
                .font(.system(size: 16))
        }
    }
}

#Preview {
    StyledText(description: "Added", value: Date().formatDate())
}
