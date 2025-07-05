//
//  InfoViewModel.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 19/05/2025.
//


import SwiftUI
import SwiftData

final class InfoViewModel: ObservableObject {
    @Published var showHowToUseTheApp = false
    var cards: [Card] = []
    
    
    
    var isReadyToRepeat: Bool {
        cards
            .filter { $0.isReadyToRepeat }
            .count > 0
    }

    func getHint() -> String {
        let readyToRepeatCards = cards.filter { $0.isReadyToRepeat }

        if cards.isEmpty {
            return TextConstants.addFirstCards
        } else if readyToRepeatCards.isEmpty {
            return TextConstants.thatsItForToday
        }

        return ""
    }
    
    func setup(cards: [Card]) {
        self.cards = cards
        showHowToUseTheApp = cards.isEmpty
    }
}

