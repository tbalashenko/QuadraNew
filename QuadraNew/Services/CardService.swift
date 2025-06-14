//
//  CardInput.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 06/06/2025.
//

import SwiftData
import Foundation

final class CardService: ObservableObject {
    func createCard(from input: CardInput, archiveTag: ArchiveTag, context: ModelContext) throws {
        let newCard = Card(
            phraseToRemember: input.phrase,
            archiveTag: archiveTag,
            cardSources: input.sources,
            translation: input.translation,
            transcription: input.transcription,
            phraseToRememberLanguage: input.phraseToRememberLanguage,
            translationLanguage: input.translationLanguage,
            imageData: input.imageData,
            croppedImageData: input.croppedImageData
        )

        context.insert(newCard)
        archiveTag.cards.append(newCard)

        input.sources.forEach { source in
            source.cards.append(newCard)
        }

        try context.save()
    }

    func updateCard(_ card: Card, with input: CardInput, context: ModelContext) throws {
        card.phraseToRemember = NSAttributedString(input.phrase)
        card.translation = NSAttributedString(input.translation)
        card.transcription = input.transcription
        card.cardSources = input.sources
        card.imageData = input.imageData
        card.croppedImageData = input.croppedImageData

        input.sources.forEach { source in
            if !source.cards.contains(card) {
                source.cards.append(card)
            }
        }
        
        try context.save()
    }

    func fetchExistingCard(_ card: Card, context: ModelContext) throws -> Card? {
        let id = card.id
        let descriptor = FetchDescriptor<Card>(predicate: #Predicate { $0.id == id })
        return try context.fetch(descriptor).first
    }
    
    func updateAfterReview(_ card: Card, context: ModelContext) {
        guard let card = try? fetchExistingCard(card, context: context) else { return }
        
        card.repetitionCounter += 1
        card.setNextReviewDate()
        card.setNewStatus()
        card.lastReviewDate = Date()
        
        do {
            try context.save()
        } catch {
            print("Failed to save card: \(error)")
        }
    }
}
