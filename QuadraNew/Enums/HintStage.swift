//
//  HintStage.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 17/06/2025.
//

import Foundation

enum HintStage: Int {
    case translation
    case definition
    case obscuredPhrase

    func next(hasDefinition: Bool) -> HintStage? {
        return switch self {
            case .translation: hasDefinition ? .definition : .obscuredPhrase
            case .definition: .obscuredPhrase
            case .obscuredPhrase: nil
        }
    }

    var isFinal: Bool {
        self == .obscuredPhrase
    }
}
