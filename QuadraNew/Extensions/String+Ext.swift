//
//  String+Ext.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 27/06/2024.
//

import Foundation
import UIKit

extension String: TextRepresentable { }

extension String: Clearable {
    static var empty: String { "" }
}

extension String {
    func attributedNs() -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: UIColor.clear,
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.black
        ]
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func attributed() -> AttributedString {
        let ns = self.attributedNs()
        return (try? AttributedString(ns, including: \.uiKit)) ?? AttributedString(self)
    }
}
