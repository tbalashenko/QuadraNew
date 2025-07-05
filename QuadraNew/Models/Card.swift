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
    var translation: NSAttributedString?
    var transcription: String?
    
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
        archiveTag: ArchiveTag,
        cardSources: [CardSource],
        translation: AttributedString? = nil,
        transcription: String? = nil,
        imageData: Data? = nil,
        croppedImageData: Data? = nil
    ) {
        self.archiveTag = archiveTag
        
        self.phraseToRemember = NSAttributedString(phraseToRemember)
        if let translation {
            self.translation = NSAttributedString(translation)
        }
        self.transcription = transcription
        self.imageData = imageData
        self.croppedImageData = croppedImageData
        self.cardSources = cardSources
    }
}
