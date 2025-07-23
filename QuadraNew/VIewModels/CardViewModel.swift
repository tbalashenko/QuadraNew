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
    @Published var phraseToRememberLanguage: Language?
    @Published var translation: AttributedString = ""
    @Published var pronunciation = ""
    @Published var definition: AttributedString = ""
    @Published var hintStage: HintStage = .translation {
        didSet {
            updateCurrentHintText()
        }
    }
    
    @Published var image: Image?
    @Published var fullImage: Image?
    
    @Published var status: CardStatus
    @Published var showAdditionalInfo: Bool = false
    
    @Published var additionalInfo = [Info]()
    @Published var tags = [TagCloudItem]()
    @Published var currentHintText: AttributedString

    private var cachedHint: AttributedString?
    
    var card: Card
    let mode: CardViewMode
    
    var showPronunciation: Bool {
        !pronunciation.isEmpty
    }
    
    
    var isFinalHintStage: Bool {
        hintStage.isFinal
    }
    
    init(card: Card, mode: CardViewMode) {
        self.card = card
        self.mode = mode
        self.phraseToRemember = AttributedString(card.phraseToRemember)
        if let languageRawValue = card.phraseToRememberLanguage {
            self.phraseToRememberLanguage = Language(rawValue: languageRawValue)
        }
        
        self.translation = AttributedString(card.translation)
        self.currentHintText = AttributedString(card.translation)
        if let pronunciation = card.pronunciation {
            self.pronunciation = pronunciation
        }
        
        if let definition = card.definition {
            self.definition =  AttributedString(definition)
        }
        
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
        additionalInfo.removeAll()
        
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
    
    func nextHintStage() {
        guard let next = hintStage.next(hasDefinition: !definition.characters.isEmpty) else { return }
        hintStage = next

        if next == .obscuredPhrase {
            cachedHint = getHint()
        }
    }
    
    func getHint() -> AttributedString {
        let words = card.phraseToRemember.string.split(separator: " ")
        
        switch words.count {
            case 1:
                let modified = phraseToRemember.characters.enumerated().map { index, char in
                    index % 2 == 0 ? "*" : char
                }
                return String(modified).attributed()
                
            case 2:
                let indexToShow = Int.random(in: 0...1)
                let modifiedWords = words.enumerated().map { index, word in
                    index == indexToShow ? String(word) : String(repeating: "*", count: word.count)
                }
                return modifiedWords.joined(separator: " ").attributed()
                
            default:
                var indices = Array(words.indices)
                indices.shuffle()
                let visibleIndices = Set(indices.prefix(words.count / 3))
                
                let modifiedWords = words.enumerated().map { index, word in
                    visibleIndices.contains(index) ? String(word) : String(repeating: "*", count: word.count)
                }
                return modifiedWords.joined(separator: " ").attributed()
        }
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
    
    
    private func updateCurrentHintText() {
        switch hintStage {
            case .translation:
                currentHintText = translation
            case .definition:
                currentHintText = definition
            case .obscuredPhrase:
                if let cachedHint {
                    currentHintText = cachedHint
                } else {
                    let hint = getHint()
                    cachedHint = hint
                    currentHintText = hint
                }
        }
    }
}
