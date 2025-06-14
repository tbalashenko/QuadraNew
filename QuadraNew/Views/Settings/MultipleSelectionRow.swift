//
//  MultipleSelectionRow.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 11/06/2025.
//

import SwiftUI

struct MultipleSelectionRow<T: Identifiable & Equatable>: View {
    let item: T
    let isSelected: Bool
    let titleProvider: (T) -> String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(titleProvider(item))
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}
