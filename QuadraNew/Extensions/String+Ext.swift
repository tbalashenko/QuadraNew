//
//  String+Ext.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 27/06/2024.
//

import Foundation

extension String: TextRepresentable { }

extension String: Clearable {
    static var empty: String { "" }
}
