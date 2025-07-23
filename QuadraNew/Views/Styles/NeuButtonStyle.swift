//
//  NeuButtonStyle.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 16/06/2025.
//

import SwiftUI

enum NeuButtonStyleForm {
    case capsule
    case roundedRectangle
}

struct NeuButtonStyle: ButtonStyle {
    var backgroundColor: Color = .element
    var foregroundColor: Color = .accentColor
    var size: ButtonSize = .m
    var withBackground: Bool = false
    var form: NeuButtonStyleForm = .capsule
    
    init(
        backgroundColor: Color = .element,
        foregroundColor: Color = .accentColor,
        size: ButtonSize = .m,
        withBackground: Bool = false,
        form: NeuButtonStyleForm = .capsule
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.size = size
        self.withBackground = withBackground
        self.form = form
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let shape = form == .capsule ? AnyShape(Capsule()) : AnyShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
        
        configuration.label
            .frame(size: size.size)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .foregroundStyle(foregroundColor)
            .if(withBackground) {
                $0.background(
                    shape
                        .fill(backgroundColor)
                        .northWestShadow(
                            radius: configuration.isPressed ? 1 : 4,
                            offset: configuration.isPressed ? 1 : 3
                        )
                        .scaleEffect(configuration.isPressed ? 0.98: 1)
                )
            }
            .if(!withBackground) {
                $0
                    .northWestShadow(
                        radius: configuration.isPressed ? 1 : 4,
                        offset: configuration.isPressed ? 1 : 3
                    )
                    .scaleEffect(configuration.isPressed ? 0.98: 1)
            }
        
    }
}

extension ButtonStyle where Self == NeuButtonStyle {
    static func neuButtonStyle(
        backgroundColor: Color = .element,
        foregroundColor: Color = .accentColor,
        size: ButtonSize = .m,
        withBackground: Bool = false,
        form: NeuButtonStyleForm = .capsule
    ) -> NeuButtonStyle {
        NeuButtonStyle(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            size: size,
            withBackground: withBackground,
            form: form
        )
    }
}

#Preview {
    NeuButton(
        image: "pencil.circle",
        action: {}
    )
    NeuButton(
        image: "pencil",
        withBackground: false,
        action: {}
    )
}
