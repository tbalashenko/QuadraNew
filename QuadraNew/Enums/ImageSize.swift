//
//  ImageSize.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 19/06/2025.
//

import Foundation

enum ImageSize {
    case small
    case medium
    case large
    
    var size: CGSize {
        switch self {
            case .small: SizeConstants.smallButtonImageSize
            case .medium: SizeConstants.mediumButtonImageSize
            case .large: SizeConstants.largeButtonImageSize
        }
    }
}
