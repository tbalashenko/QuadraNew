//
//  SetupCardViewModel.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 28/05/2025.
//

import SwiftUI
import Combine
import SwiftData

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
    
    var cancellables: Set<AnyCancellable> = []
    
    let mode: SetupCardViewMode
    
    var isSaveButtonDisabled: Bool {
        phraseToRemember.characters.isEmpty || !translationError.isEmpty && !transcriptionError.isEmpty
    }
    
    init(mode: SetupCardViewMode = .create, sources: [CardSource]) {
        self.mode = mode
        self.sources = sources
        
        setupBindings()
    }
    
    func formatAndSetPhrase(_ text: String, string: inout AttributedString) {
        let updatedAttributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: UIColor.clear,
            .font: UIFont.systemFont(ofSize: 18),
            .foregroundColor: UIColor.black
        ]
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(updatedAttributes, range: NSRange(location: 0, length: attributedString.length))
        
        string = AttributedString(attributedString)
    }
    
    @MainActor
    func saveCard(context: ModelContext) {
        guard let tag = try? getOrCreateArchiveTag(context: context) else { return }
        
        let card = Card(
            phraseToRemember: phraseToRemember,
            archiveTag: tag,
            cardSources: selectedSources,
            translation: translation,
            transcription: transcription,
            imageData: image?.convert(scale: SettingsService.imageScale)?.pngData(),
            croppedImageData: croppedImage?.convert(scale: SettingsService.imageScale)?.pngData()
        )
        
        if mode == .create {
            context.insert(card)
        
            tag.cards.append(card)
            
            sources.forEach { source in
                source.cards.append(card)
            }
        } else {
#warning("")
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save card: \(error.localizedDescription)")
        }
        
        FilterService.shared.reset()
    }
}



