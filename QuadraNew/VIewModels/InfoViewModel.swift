//
//  InfoViewModel.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 19/05/2025.
//


import SwiftUI
import Combine

final class InfoViewModel: ObservableObject {
    let noReadyToReviewCardsHint = TextConstants.thatsItForToday
    
    var cards: [Card] = []
    
    var isReadyToRepeat: Bool {
        cards
            .filter { $0.isReadyToRepeat }
            .count > 0
    }
    
    func setup(cards: [Card]) {
        self.cards = cards
    }
}

