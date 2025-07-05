//
//  TagCloudItem.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

class TagCloudItem: ObservableObject {
    var isSelected: Bool
    var id: UUID
    var title: String
    var isExceeded = false
    var action: (() -> Void)?
    var color: Color

    init(isSelected: Bool, id: UUID, title: String, color: Color, action: (() -> Void)? = nil) {
        self.isSelected = isSelected
        self.id = id
        self.title = title
        self.color = color
        self.action = action
    }
}

// MARK: - Identifiable
extension TagCloudItem: Identifiable { }

// MARK: - Equatable
extension TagCloudItem: Equatable {
    static func == (lhs: TagCloudItem, rhs: TagCloudItem) -> Bool {
        return lhs.id == rhs.id
    }
}
