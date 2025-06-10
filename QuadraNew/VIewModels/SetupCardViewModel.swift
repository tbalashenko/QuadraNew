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
    
    @Published var transcription = ""
    @Published var isTranscriptionValid: Bool = false
    @Published var transcriptionError = ""
    
    @Published var newSourceText = ""
    @Published var sourceColor = Color.morningBlue
    
    @Published var sources: [CardSource] = []
    @Published var tagCloudItems: [TagCloudItem] = []
    @Published var selectedSources = [CardSource]()
    
    let mode: SetupCardViewMode
    var card: Card?
    
    var cancellables: Set<AnyCancellable> = []
    
    var wasChanged: Bool { !phraseToRemember.isEmpty }
    
    var isSaveButtonDisabled: Bool {
        phraseToRemember.isEmpty || !translationError.isEmpty && !transcriptionError.isEmpty
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
            if let translation = card.translation {
                self.translation = AttributedString(translation)
            }
            self.transcription = card.transcription ?? ""
            
            let image = card.imageData.flatMap { UIImage(data: $0) }.map { Image(uiImage: $0) }
            let croppedImage = card.croppedImageData.flatMap { UIImage(data: $0) }.map { Image(uiImage: $0) }
            
            self.croppedImage = croppedImage ?? image
            self.image = image
            
            self.selectedSources = card.cardSources ?? []
            updateTagCloudItems()
        }
    }
    
    func saveCard(context: ModelContext, cardService: CardService, settings: SettingsService) async {
        do {
            let input = makeCardInput(settings: settings)
            
            if mode == .create {
                let archiveTag = try getOrCreateArchiveTag(context: context)
                
                try cardService.createCard(from: input, archiveTag: archiveTag, context: context)
            } else if let card = card, let existingCard = try cardService.fetchExistingCard(card, context: context) {
                try cardService.updateCard(existingCard, with: input, context: context)
            }
            
            FilterService.shared.reset()
        } catch {
            print("Failed to save card: \(error.localizedDescription)")
        }
    }
}
