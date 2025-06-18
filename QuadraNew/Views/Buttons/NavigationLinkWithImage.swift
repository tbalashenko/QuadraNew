//
//  NavigationLinkWithImage.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 31/05/2025.
//

import SwiftUI

struct NavigationLinkWithImage<Destination: View>: View {
    var destination: () -> Destination
    var image: String

    var body: some View {
        NavigationLink(destination: destination) {
            Image(systemName: image)
                .smallButtonImage()
                .foregroundStyle(Color.accentColor)
        }
        .buttonStyle(NeuButtonStyle(size: SizeConstants.smallButtonSize))
    }
}
