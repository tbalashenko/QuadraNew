//
//  SetupCardViewModel.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 28/05/2025.
//
import SwiftUI
import Combine
import SwiftData

@MainActor
final class SetupCardViewModel: ObservableObject {
    @Published var image: Image?
    @Published var croppedImage: Image?
    @Published var showImageUrlSection = false
    
    @Published var phraseToRemember: AttributedString = ""
    @Published var isPhraseToRememberValid: Bool = false
    @Published var phraseToRememberError = ""
    
    @Published var url = ""
    @Published var urlError = ""
    
    @Published var translation: AttributedString = ""
    @Published var isTranslationValid: Bool = false
    @Published var translationError = ""
    
    @Published var pronunciation = ""
    @Published var isPronunciationValid: Bool = true
    @Published var pronunciationError = ""
    
    @Published var definition: AttributedString = ""
    @Published var isDefinitionValid: Bool = true
    @Published var definitionError = ""
    
    @Published var phraseToRememberLanguage: Language? = nil
    
    @Published var newSourceText = ""
    @Published var sourceColor = Color.morningBlue
    
    @Published var sources: [CardSource] = []
    @Published var sourcesTagCloudItems: [TagCloudItem] = []
    @Published var selectedSources = [CardSource]()
    
    let mode: SetupCardViewMode
    var card: Card?
    
    var cancellables: Set<AnyCancellable> = []
    
    var wasChanged: Bool { !phraseToRemember.isEmpty }
    
    var isSaveButtonEnabled: Bool {
        !phraseToRemember.isEmpty &&
        !translation.isEmpty &&
        isPhraseToRememberValid &&
        isTranslationValid &&
        isPronunciationValid &&
        isDefinitionValid
    }
    
    init(
        mode: SetupCardViewMode,
        sources: [CardSource],
        card: Card? = nil
    ) {
        self.mode = mode
        self.sources = sources
        
        setupBindings()
        
        if let card {
            self.card = card
            self.phraseToRemember = AttributedString(card.phraseToRemember)
            self.translation = AttributedString(card.translation)
            self.pronunciation = card.pronunciation ?? ""
            if let definition = card.definition {
                self.definition = AttributedString(definition)
            }
            
            if let phraseToRememberLanguage = card.phraseToRememberLanguage {
                self.phraseToRememberLanguage = Language(rawValue: phraseToRememberLanguage)
            }
            
            let image = card.imageData.flatMap { UIImage(data: $0) }.map { Image(uiImage: $0) }
            let croppedImage = card.croppedImageData.flatMap { UIImage(data: $0) }.map { Image(uiImage: $0) }
            
            self.croppedImage = croppedImage ?? image
            self.image = image
            
            self.selectedSources = card.cardSources ?? []
            updateSourceTagCloudItems()
        }
    }
    
    func saveCard(context: ModelContext, cardService: CardService, settings: SettingsService, filterService: FilterService) async {
        do {
            let input = makeCardInput(settings: settings)
            
            if mode == .create {
                let archiveTag = try getOrCreateArchiveTag(context: context)
                
                try cardService.createCard(from: input, archiveTag: archiveTag, context: context)
            } else if let card = card, let existingCard = try cardService.fetchExistingCard(card, context: context) {
                try cardService.updateCard(existingCard, with: input, context: context)
            }
            
            filterService.reset()
        } catch {
            print("Failed to save card: \(error.localizedDescription)")
        }
    }
}
