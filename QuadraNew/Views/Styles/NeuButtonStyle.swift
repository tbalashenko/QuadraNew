//
//  NeuButtonStyle.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 16/06/2025.
//

import SwiftUI

struct NeuButtonStyle: ButtonStyle {
    enum NeuButtonStyleForm {
        case capsule
        case roundedRectangle
    }
    
    var color = Color.element
    var size: CGSize
    var withBackground: Bool = false
    var form: NeuButtonStyleForm = .capsule
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let shape = form == .capsule ? AnyShape(Capsule()) : AnyShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
        
        configuration.label
            .frame(size: size)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .if(withBackground) {
                $0.background(
                    shape
                        .fill(color)
                        .northWestShadow(
                            radius: configuration.isPressed ? 1 : 2,
                            offset: configuration.isPressed ? 1 : 2
                        )
                        .scaleEffect(configuration.isPressed ? 0.98: 1)
                )
            }
            .if(!withBackground) {
                $0
                    .northWestShadow(
                        radius: configuration.isPressed ? 1 : 2,
                        offset: configuration.isPressed ? 1 : 2
                    )
                    .scaleEffect(configuration.isPressed ? 0.98: 1)
            }
        
    }
}

#Preview {
    SmallButton(
        image: "pencil.circle",
        withBackground: true,
        action: {}
    )
    SmallButton(
        image: "pencil",
        withBackground: false,
        action: {}
    )
}
