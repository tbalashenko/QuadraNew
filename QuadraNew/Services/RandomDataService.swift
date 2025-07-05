//
//  RandomDataService.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 10/06/2024.
//

import Foundation
import SwiftData
import SwiftUI

final class RandomDataService {
//    static let shared = RandomDataService()
//    private init() { }
//
//    func addRandomData(in modelContext: ModelContext) async {
//        let fromDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
//        
//        for index in stride(from: 0, to: 366, by: 2) {
//            let date = Calendar.current.date(byAdding: .day, value: index, to: fromDate) ?? Date()
//            let string = "Test" + String("\(date)")
//            let phraseToRemember = AttributedString(stringLiteral: string)
//            #warning("ArchiveTag should be created or fetched")
//            //let archiveTag = ArchiveTag.getOrCreate(in: modelContext)
//                
//            
//#warning("incrementAddedItemsCounter")
//            let card = Card(additionTime: date, phraseToRemember: phraseToRemember, archiveTag: archiveTag, sources: [])
//            
//            modelContext.insert(card)
//            
//            let currentDate = date.formattedForStats()
//            
//            try? await upsertStatData(date: currentDate ?? Date(), in: modelContext)
//            
//            try? modelContext.save()
//        }
//    }
//    
//    func upsertStatData(date: Date, in modelContext: ModelContext) async throws {
//        let descriptor = FetchDescriptor<StatData>(
//            predicate: #Predicate { $0.date == date }
//        )
//        
//        let existing = try modelContext.fetch(descriptor)
//        
//        if let statData = existing.first {
//            statData.repeatedItemsCounter = Int.random(in: 1...5)
//            statData.addedItemsCounter = Int.random(in: 1...3)
//            statData.deletedItemsCounter = Int.random(in: 0...1)
//        } else {
//            let totalCards = try modelContext.fetch(FetchDescriptor<Card>()).count
//            
//            let newStatData = StatData(
//                addedItemsCounter: Int.random(in: 1...3),
//                date: date,
//                deletedItemsCounter: Int.random(in: 0...1),
//                repeatedItemsCounter: Int.random(in: 1...5),
//                totalNumberOfCards: totalCards
//            )
//            
//            modelContext.insert(newStatData)
//        }
//    }
}
