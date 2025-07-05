//
//  NavigationLinkWithTextAndImage.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 29/05/2025.
//

import SwiftUI


struct NavigationLinkWithTextAndImage<Destination: View>: View {
    var destination: () -> Destination
    var title: String
    var image: String

    var body: some View {
        NavigationLink {
            destination()
        } label: {
            Label(title, systemImage: image)
        }
        .buttonStyle(NeuButtonStyle(size: SizeConstants.plainButtonSize))
    }
}
