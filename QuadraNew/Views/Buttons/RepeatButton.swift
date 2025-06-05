//
//  RepeatButton.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 02/06/2025.
//

import SwiftUI

struct RepeatButton: View {
    var action: () -> Void
    
    var body: some View {
        PlainButtonWithImage(
            title: TextConstants.restart,
            image: "repeat.circle"
        ) {
            action()
        }
    }
}
