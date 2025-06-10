//
//  CardViewModel.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 29/05/2025.
//

import SwiftUI
import SwiftData

@MainActor
final class CardViewModel: ObservableObject {
    @Published var phraseToRemember: AttributedString = ""
    @Published var translation: AttributedString = ""
    @Published var transcription = ""
        
    @Published var image: Image?
    @Published var fullImage: Image?
    
    @Published var status: CardStatus
    @Published var showAdditionalInfo: Bool = false
    
    @Published var additionalInfo = [Info]()
    @Published var tags = [TagCloudItem]()
    
    var card: Card
    let mode: CardViewMode
    
    var isFlippable: Bool {
        !translation.isEmpty
    }
    
    var showTranscription: Bool {
        !transcription.isEmpty && showAdditionalInfo
    }
    
    init(card: Card, mode: CardViewMode) {
        self.card = card
        self.mode = mode
        self.phraseToRemember = AttributedString(card.phraseToRemember)
        if let translation = card.translation {
            self.translation = AttributedString(translation)
        }
        self.transcription = card.transcription ?? ""
        
        self.status = CardStatus(card.cardStatus)
        
        let image = card.imageData.flatMap { UIImage(data: $0) }.map { Image(uiImage: $0) }
        let croppedImage = card.croppedImageData.flatMap { UIImage(data: $0) }.map { Image(uiImage: $0) }

        self.image = croppedImage ?? image
        self.fullImage = image
        
        if mode == .view {
            prepareAdditionalInfo()
        }
        prepareTags()
    }
    
    func prepareAdditionalInfo() {
        additionalInfo.append(Info(description: TextConstants.added, value: card.creationDate.formatDate()))
        additionalInfo.append(Info(description: TextConstants.numberOfRepetitions, value: String(card.repetitionCounter)))
        
        if let lastReviewDate = card.lastReviewDate {
            additionalInfo.append(Info(description: TextConstants.lastReview, value: lastReviewDate.formatDate()))
        }
    }
    
    private func prepareTags() {
        tags.removeAll()
        
        if let tag = prepareArchiveTag() {
            tags.append(tag)
        }
        
        if let tag = prepareStatusTag() {
            tags.append(tag)
        }
        
        if let tags = prepareSourceTags() {
            self.tags.append(contentsOf: tags)
        }
    }
    
    private func prepareArchiveTag() -> TagCloudItem?  {
        guard card.cardStatus == 91, let cardArchiveTag = card.archiveTag else { return nil }
        
        let archiveTag = TagCloudItem(
            isSelected: true,
            id: cardArchiveTag.id,
            title: cardArchiveTag.title,
            color: Color.gray
        )
        
        return archiveTag
    }
    
    private func prepareStatusTag() -> TagCloudItem? {
        guard let status = CardStatus(rawValue: card.cardStatus) else { return nil }
        
        let statusTag = TagCloudItem(
            isSelected: true,
            id: UUID(uuidString: String(status.id)) ?? UUID(),
            title: status.title,
            color: status.color
        )
        
        return statusTag
    }
    
    private func prepareSourceTags() -> [TagCloudItem]? {
        guard let cardSources = card.cardSources else { return nil }
        
        let sourceTags = cardSources.map { source in
            TagCloudItem(
                isSelected: true,
                id: source.id,
                title: source.title,
                color: Color(hex: source.color)
            )
        }
        
        return sourceTags
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
