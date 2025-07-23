//
//  ButtonSize.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 19/06/2025.
//

import Foundation

enum ButtonSize {
    case xxs
    case xs
    case s
    case m
    case l
    case plain
    
    var size: CGSize {
        switch self {
            case .xxs: SizeConstants.miniButtonSize
            case .xs: SizeConstants.miniButtonSize
            case .s: SizeConstants.smallButtonSize
            case .m: SizeConstants.mediumButtonSize
            case .l: SizeConstants.largeButtonSize
            case .plain: SizeConstants.plainButtonSize
        }
    }
}
