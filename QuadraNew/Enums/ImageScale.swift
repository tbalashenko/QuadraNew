//
//  ImageScale.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import Foundation

enum ImageScale: Double, RawRepresentable, CaseIterable {
    case percent50 = 0.5
    case percent60 = 0.6
    case percent70 = 0.7
    case percent80 = 0.8
    case percent90 = 0.9
    case percent100 = 1.0
    
    var value: String {
        return switch self {
            case .percent50: "50%"
            case .percent60: "60%"
            case .percent70: "70%"
            case .percent80: "80%"
            case .percent90: "90%"
            case .percent100: "100%"
        }
    }
}
