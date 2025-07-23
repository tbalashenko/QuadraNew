//
//  RandomDataService.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 10/06/2024.
//

import Foundation
import SwiftData
import SwiftUI

final class RandomDataService: ObservableObject {
    
    let statDataService: StatDataService
    
    init(statDataService: StatDataService) {
        self.statDataService = statDataService
    }
    
    func getOrCreateArchiveTag(context: ModelContext, for date: Date) throws -> ArchiveTag {
        let tagTitle = date.prepareTagTitle()
        let descriptor = FetchDescriptor<ArchiveTag>(predicate: #Predicate { $0.title == tagTitle })
        
        if let existingTag = try context.fetch(descriptor).first {
            return existingTag
        } else {
            let newTag = ArchiveTag(date: date)
            
            context.insert(newTag)
            try? context.save()
            
            return newTag
        }
    }
    
    
    func addRandomData(in context: ModelContext) {
        let fromDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        
        for index in stride(from: 0, to: 366, by: 2) {
            let date = Calendar.current.date(byAdding: .day, value: index, to: fromDate) ?? Date()
            let string = "Test" + String("\(date)")
            let phraseToRemember = AttributedString(stringLiteral: string)
            let translation = AttributedString(stringLiteral: string)
            let archiveTag = try! getOrCreateArchiveTag(context: context, for: date)
            
            let card = Card(
                phraseToRemember: phraseToRemember,
                translation: translation,
                archiveTag: archiveTag,
                cardSources: [],
                phraseToRememberLanguage: Language.english.rawValue,
                creationDate: date
            )
            
            context.insert(card)
            let currentDate = date.formattedForStats()
            
            try? upsertStatData(date: currentDate ?? Date(), in: context)
        }
    }
    
    
    func upsertStatData(date: Date, in context: ModelContext) throws {
        let descriptor = FetchDescriptor<StatData>(
            predicate: #Predicate { $0.date == date }
        )
        
        let existing = try context.fetch(descriptor)
        
        if let statData = existing.first {
            statData.repeatedItemsCounter = Int.random(in: 1...5)
            statData.addedItemsCounter = Int.random(in: 1...3)
            statData.deletedItemsCounter = Int.random(in: 0...1)
            statData.memorizedItemsCounter = Int.random(in: 0...3)
        } else {
            let totalCards = try context.fetch(FetchDescriptor<Card>()).count
            
            let newStatData = StatData(
                date: date,
                addedItemsCounter: Int.random(in: 1...3),
                deletedItemsCounter: Int.random(in: 0...1),
                repeatedItemsCounter: Int.random(in: 1...5),
                memorizedItemsCounter: Int.random(in: 0...3),
                totalNumberOfCards: totalCards
            )
            
            context.insert(newStatData)
        }
        
        try? context.save()
    }
}
