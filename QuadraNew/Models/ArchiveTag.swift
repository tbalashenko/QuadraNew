//
//  CardArchiveTag.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 28/05/2025.
//

import SwiftData
import Foundation

@Model
final class ArchiveTag {
    @Attribute(.unique)
    var id = UUID()
    
    var color: String
    var title: String
    
    @Relationship(inverse: \Card.archiveTag)
    var cards: [Card] = []
    
    init(date: Date = Date()) {
        self.color = ArchiveTag.getColor(for: date)
        self.title = date.prepareTagTitle()
    }
}
    
