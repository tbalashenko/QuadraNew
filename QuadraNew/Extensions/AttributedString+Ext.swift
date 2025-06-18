//
//  AttributedString+Ext.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 23/04/2024.
//

import Foundation
import SwiftUI

// MARK: - TextRepresentable
extension AttributedString: TextRepresentable {
    var count: Int {
        self.characters.count
    }
}

extension AttributedString {
    var isEmpty: Bool {
        self.characters.isEmpty
    }
    
    func applyingFont(_ font: Font) -> AttributedString {
        var result = self
        for run in result.runs {
            let range = run.range
            result[range].font = font
        }
        return result
    }
}

// MARK: - TextRepresentable
extension AttributedString: Clearable {
    static var empty: AttributedString { AttributedString("") }
}
