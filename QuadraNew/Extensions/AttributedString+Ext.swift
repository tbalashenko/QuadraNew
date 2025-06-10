//
//  AttributedString+Ext.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 23/04/2024.
//

import Foundation

extension AttributedString: TextRepresentable {
    var count: Int {
        self.characters.count
    }
}

extension AttributedString {
    var isEmpty: Bool {
        self.characters.isEmpty
    }
}

extension AttributedString: Clearable {
    static var empty: AttributedString { AttributedString("") }
}
