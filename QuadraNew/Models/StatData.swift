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
    var totalNumberOfCards: Int
    
    init(date: Date, addedItemsCounter: Int, deletedItemsCounter: Int, repeatedItemsCounter: Int, totalNumberOfCards: Int) {
        self.date = date
        self.addedItemsCounter = addedItemsCounter
        self.deletedItemsCounter = deletedItemsCounter
        self.repeatedItemsCounter = repeatedItemsCounter
        self.totalNumberOfCards = totalNumberOfCards
    }
}
