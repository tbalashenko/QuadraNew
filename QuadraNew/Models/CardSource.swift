//
//  CardSourceModel.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import Foundation
import SwiftData

@Model
final class CardSource {
    @Attribute(.unique)
    var id: UUID = UUID()
    
    var title: String
    var color: String
    
    @Relationship(inverse: \Card.cardSources)
    var cards: [Card]
    
    init(title: String, color: String) {
        self.title = title
        self.color = color
        self.cards = []
    }
}

// MARK: - Identifiable
extension CardSource: Identifiable { }
