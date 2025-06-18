//
//  Card.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 23/05/2025.
//

import Foundation
import SwiftData

@Model
final class Card {
    @Attribute(.unique)
    var id: UUID = UUID()
    
    var cardStatus: Int = 0
    var isArchived: Bool = false
    var repetitionCounter: Int = 0
    
    var creationDate: Date = Date()
    var lastReviewDate: Date?
    // first time is right after creation
    var nextReviewDate: Date = Date()
    
    @Attribute(.transformable(by: "AttributedStringTransformer"))
    var phraseToRemember: NSAttributedString
    @Attribute(.transformable(by: "AttributedStringTransformer"))
    var translation: NSAttributedString
    @Attribute(.transformable(by: "AttributedStringTransformer"))
    var definition: NSAttributedString?
    var transcription: String?
    var phraseToRememberLanguage: String?
    
    @Attribute(.externalStorage)
    var imageData: Data?
    @Attribute(.externalStorage)
    var croppedImageData: Data?
    
    @Relationship
    var archiveTag: ArchiveTag?
    
    @Relationship
    var cardSources: [CardSource]?
    
    init(
        phraseToRemember: AttributedString,
        translation: AttributedString,
        archiveTag: ArchiveTag,
        cardSources: [CardSource],
        definition: AttributedString? = nil,
        transcription: String? = nil,
        phraseToRememberLanguage: String?,
        imageData: Data? = nil,
        croppedImageData: Data? = nil
    ) {
        self.archiveTag = archiveTag
        
        self.phraseToRemember = NSAttributedString(phraseToRemember)
        self.translation = NSAttributedString(translation)
        if let definition = definition {
            self.definition = NSAttributedString(definition)
        }
        self.transcription = transcription
        self.phraseToRememberLanguage = phraseToRememberLanguage
        self.imageData = imageData
        self.croppedImageData = croppedImageData
        self.cardSources = cardSources
    }
}
