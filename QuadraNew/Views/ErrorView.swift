//
//  ErrorView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 09/06/2025.
//

import SwiftUI

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
