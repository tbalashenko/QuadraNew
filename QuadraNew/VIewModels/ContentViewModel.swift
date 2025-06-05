//
//  ContentViewModel.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 29/05/2025.
//

import Combine
import SwiftUI
import SwiftData

final class ContentViewModel: ObservableObject {
    @Published var visibleCardModels = [CardViewModel]()
    @Published var showConfetti = false
    @Published var showInfoView = true
    @Published var readyToRepeatCards: [Card] = []
    
    var totalNumberOfCards = 0
    var numberOfReviewedCards = 0
    
    var cards = [Card]()
    
    var progressViewLabel: String { "\(totalNumberOfCards - numberOfReviewedCards) left" }
    var progress: Double { totalNumberOfCards == 0 ? 0 : Double(numberOfReviewedCards) / Double(totalNumberOfCards) }
    
    func setCards(_ cards: [Card]) {
        self.cards = cards
        
        readyToRepeatCards = cards
            .filter { $0.isReadyToRepeat }
        
        numberOfReviewedCards = 0
        totalNumberOfCards = readyToRepeatCards.count
        
        showInfoView = readyToRepeatCards.isEmpty
    }
    
    func swipeCard(context: ModelContext, card: Card) {
        readyToRepeatCards.removeAll(where: { $0.id == card.id })
        
        let id = card.id
        let descriptor = FetchDescriptor<Card>(predicate: #Predicate { $0.id == id })
        
        if let card = try? context.fetch(descriptor).first {
            card.repetitionCounter += 1
            card.setNextReviewDate()
            card.setNewStatus()
            
            do {
                try context.save()
            } catch {
                print("Failed to save card: \(error)")
            }
        }
        
        numberOfReviewedCards += 1
        showConfetti = readyToRepeatCards.isEmpty
        showInfoView = readyToRepeatCards.isEmpty
    }
}
