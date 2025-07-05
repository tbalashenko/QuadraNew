//
//  CardViewModel.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 29/05/2025.
//

import SwiftUI
import SwiftData

final class CardViewModel: ObservableObject {
    @Published var phraseToRemember: AttributedString = ""
    @Published var translation: AttributedString = ""
    @Published var transcription = ""
        
    @Published var image: Image?
    @Published var fullImage: Image?
    
    @Published var status: CardStatus
    @Published var showAdditionalInfo: Bool = false
    
    var card: Card
    
    var isFlippable: Bool {
        !translation.isEmpty
    }
    
    var showTranscription: Bool {
        !transcription.isEmpty && showAdditionalInfo
    }
    
    init(card: Card) {
        self.card = card
        self.phraseToRemember = AttributedString(card.phraseToRemember)
        if let translation = card.translation {
            self.translation = AttributedString(translation)
        }
        self.transcription = card.transcription ?? ""
        
        self.status = CardStatus(card.cardStatus)
        self.image = card.croppedImage ?? card.image
        self.fullImage = card.image
    }
    
#warning("return back this functionality")
    func backToInput(context: ModelContext) {
//        let cardId = card.id
//        
//        let descriptor = FetchDescriptor<Card>(predicate: #Predicate { $0.id == cardId })
//
//        if let existingCard = try? context.fetch(descriptor).first {
//            existingCard.cardStatus = CardStatus.input.rawValue
//            
//            try? context.save()
//        }
    }
}
