//
//  Image+Ext.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

extension Image {
    @MainActor
    func convert(scale: ImageScale) -> UIImage? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = scale.rawValue
        return renderer.uiImage
    }
    
    func setupButtonImage(size: ImageSize) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(size: size.size)
    }
}
