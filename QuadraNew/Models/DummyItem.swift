//
//  DummyItem.swift
//  QuadraSD
//
//  Created by Tatyana Balashenko on 20/05/2025.
//

import Foundation
import SwiftUI

struct DummyItem {
    var id = UUID()
    var title: String
    var image: Image
}

// MARK: - Identifiable
extension DummyItem: Identifiable { }
