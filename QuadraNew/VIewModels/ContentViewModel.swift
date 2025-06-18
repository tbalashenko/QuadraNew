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
    
    func swipeCard(card: Card, cardService: CardService, context: ModelContext, swipeSide: SwipeAction) {
        readyToRepeatCards.removeAll(where: { $0.id == card.id })
        
        cardService.updateAfterReview(card, context: context, swipeSide: swipeSide)
        
        numberOfReviewedCards += 1
        showConfetti = readyToRepeatCards.isEmpty
        showInfoView = readyToRepeatCards.isEmpty
    }
}
