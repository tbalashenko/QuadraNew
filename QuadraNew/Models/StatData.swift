//
//  StatData.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 29/05/2025.
//

import SwiftData
import Foundation

@Model
final class StatData {
    @Attribute(.unique)
    public var id: UUID = UUID()
    
    var date: Date
    var addedItemsCounter: Int
    var deletedItemsCounter: Int
    var repeatedItemsCounter: Int
    var memorizedItemsCounter: Int
    var totalNumberOfCards: Int
    
    init(
        date: Date = Date(),
        addedItemsCounter: Int = 0,
        deletedItemsCounter: Int = 0,
        repeatedItemsCounter: Int = 0,
        memorizedItemsCounter: Int = 0,
        totalNumberOfCards: Int = 0
    ) {
        self.date = date.formattedForStats() ?? Date()
        self.addedItemsCounter = addedItemsCounter
        self.deletedItemsCounter = deletedItemsCounter
        self.repeatedItemsCounter = repeatedItemsCounter
        self.memorizedItemsCounter = memorizedItemsCounter
        self.totalNumberOfCards = totalNumberOfCards
    }
}
