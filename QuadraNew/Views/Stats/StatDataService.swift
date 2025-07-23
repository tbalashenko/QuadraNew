//
//  StatDataService.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 14/05/2024.
//

import Foundation
import SwiftData

final class StatDataService: ObservableObject {
    
    init() {
        
    }
    
    private func fetchOrCreateStatData(context: ModelContext, for date: Date = Date()) -> StatData? {
        let currentDate = date.formattedForStats() ?? Date()
        let descriptor = FetchDescriptor<StatData>(predicate: #Predicate { $0.date == currentDate })
        
        if let statData = try? context.fetch(descriptor).first {
            return statData
        } else {
            let newStatData = StatData()
            
            context.insert(newStatData)
            newStatData.totalNumberOfCards = fetchCardsCount(context: context)
            
            saveContext(context, errorMessage: "Error creating statData")
            
            return newStatData
        }
    }
    
    func incrementRepeatedItemsCounter(context: ModelContext) {
        guard let statData = fetchOrCreateStatData(context: context) else { return }
        
        statData.repeatedItemsCounter += 1
        
        saveContext(context, errorMessage: "Error saving repeatedItems statData")
    }
    
    func incrementAddedItemsCounter(context: ModelContext) {
        guard let statData = fetchOrCreateStatData(context: context) else { return }
        
        statData.addedItemsCounter += 1
        statData.totalNumberOfCards = fetchCardsCount(context: context)
        
        saveContext(context, errorMessage: "Error saving addedItems statDat")
    }
    
    func incrementDeletedItemsCounter(context: ModelContext) {
        guard let statData = fetchOrCreateStatData(context: context) else { return }
        
        statData.deletedItemsCounter += 1
        statData.totalNumberOfCards = fetchCardsCount(context: context)
        
        saveContext(context, errorMessage: "Error saving deletedItems statDat")
    }
    
    func incrementMemorizedItemsCounter(context: ModelContext) {
        guard let statData = fetchOrCreateStatData(context: context) else { return }
        
        statData.memorizedItemsCounter += 1
        
        saveContext(context, errorMessage: "Error saving memorizedItems statDat")
    }
    
//    func saveStatData(
//        context: ModelContext,
//        date: Date = Date(),
//        repeatedItemsCounter: Int = 0,
//        addedItemsCounter: Int = 0,
//        memorizedItemsCounter: Int = 0,
//        deletedItemsCounter: Int = 0
//    ) {
//        guard let statData = fetchOrCreateStatData(context: context, for: date) else { return }
//
//        statData.repeatedItemsCounter = repeatedItemsCounter
//        statData.addedItemsCounter = addedItemsCounter
//        statData.deletedItemsCounter = deletedItemsCounter
//        statData.memorizedItemsCounter = memorizedItemsCounter
//        statData.totalNumberOfCards = fetchCardsCount(context: context)
//        statData.date = date
//        
//        saveContext(context, errorMessage: "Failed to save StatData")
//    }
    
    private func fetchCardsCount(context: ModelContext) -> Int {
        (try? context.fetch(FetchDescriptor<Card>())).map(\.count) ?? 0
    }
    
    private func saveContext(_ context: ModelContext, errorMessage: String) {
        do {
            try context.save()
        } catch {
            print("\(errorMessage): \(error.localizedDescription)")
        }
    }
}
