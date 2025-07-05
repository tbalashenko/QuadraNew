//
//  Image+Ext.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

extension Image {
    @MainActor
    func convert(scale: ImageScale = SettingsService.imageScale) -> UIImage? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = scale.rawValue
        return renderer.uiImage
    }
    
    func smallButtonImage() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(size: SizeConstants.smallButtonImageSize)
    }
}
