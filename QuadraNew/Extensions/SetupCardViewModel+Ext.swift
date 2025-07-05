//
//  SetupCardViewModel+Ext.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 28/05/2025.
//

import SwiftUI
import Combine
import SwiftData

// MARK: - Combine
extension SetupCardViewModel {
    func setupBindings() {
        setupPhraseToRemember()
        setupTranslation()
        setupTranscription()
        setupNewSourceText()
    }
    
    private func setupPhraseToRemember() {
        $phraseToRemember
            .receive(on: RunLoop.main)
            .map { $0.count <= SizeConstants.textLimit }
            .assign(to: \.isPhraseToRememberValid, on: self)
            .store(in: &cancellables)
        $isPhraseToRememberValid
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                guard let self = self else { return }
                
                isValid ? (self.phraseToRememberError = "") : Helper.getErrorMessage(for: self.phraseToRemember, errorText: &self.phraseToRememberError)
            }
            .store(in: &cancellables)
    }
    
    private func setupTranslation() {
        $translation
            .receive(on: RunLoop.main)
            .map { $0.count <= SizeConstants.textLimit }
            .assign(to: \.isTranslationValid, on: self)
            .store(in: &cancellables)
        $isTranslationValid
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                guard let self = self else { return }
                
                isValid ? (self.translationError = "") : Helper.getErrorMessage(for: self.translation, errorText: &self.translationError)
            }
            .store(in: &cancellables)
    }
    
    private func setupTranscription() {
        $transcription
            .receive(on: RunLoop.main)
            .map { $0.count <= SizeConstants.textLimit }
            .assign(to: \.isTranscriptionValid, on: self)
            .store(in: &cancellables)
        $isTranscriptionValid
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                guard let self = self else { return }
                
                isValid ? (self.transcriptionError = "") : Helper.getErrorMessage(for: self.transcription, errorText: &self.transcriptionError)
            }
            .store(in: &cancellables)
    }
    
    private func setupNewSourceText() {
        $newSourceText
            .sink { [weak self] _ in
                self?.updateTagCloudItems()
            }
            .store(in: &cancellables)
    }
}


// MARK: - ArchiveTag Management
extension SetupCardViewModel {
    func getOrCreateArchiveTag(context: ModelContext) throws -> ArchiveTag {
        let tagTitle = Date().prepareTagTitle()
        let descriptor = FetchDescriptor<ArchiveTag>(predicate: #Predicate { $0.title == tagTitle })
        
        if let existingTag = try context.fetch(descriptor).first {
            return existingTag
        } else {
            let newTag = ArchiveTag()
            
            context.insert(newTag)
            try? context.save()
            
            return newTag
        }
    }
}

// MARK: - CardSource Management
extension SetupCardViewModel {
    func saveSource(context: ModelContext) {
        guard !newSourceText.isEmpty else { return }
        
        let source = CardSource(title: newSourceText, color: sourceColor.toHex())
        
        context.insert(source)
        try? context.save()
        
        selectedSources.append(source)
        
        newSourceText = ""
        sourceColor = Color.morningBlue
        
        guard let updatedSources = try? context.fetch(FetchDescriptor<CardSource>()) else { return }
        
        sources = updatedSources
    }
    
    private func toggleSourceSelection(source: CardSource) {
        selectedSources.contains(source) ? selectedSources.removeAll { $0.id == source.id } : selectedSources.append(source)
    }
    
    func updateTagCloudItems() {
        tagCloudItems = sources
            .filter { newSourceText.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(newSourceText) }
            .map { source in
                TagCloudItem(
                    isSelected: selectedSources.contains(source),
                    id: source.id,
                    title: source.title,
                    color: Color(hex: source.color)
                ) { [weak self] in
                    self?.toggleSourceSelection(source: source)
                }
            }
    }
}

// MARK: - Image Downloading
extension SetupCardViewModel {
    func downloadImage() {
        guard let url = URL(string: url) else { return }
        
        guard NetworkMonitor.shared.isConnected else { urlError = TextConstants.checkInternetConnection; return }
        
        urlError = ""
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        self.urlError = TextConstants.failedToDownloadImage + (error.localizedDescription)
                    case .finished:
                        break
                }
            }, receiveValue: { data in
                guard let uiImage = UIImage(data: data) else {
                    self.urlError = TextConstants.somethingWentWrong
                    print("Failed to create image from data")
                    return
                }
                
                self.image = Image(uiImage: uiImage)
                self.croppedImage = Image(uiImage: uiImage)
            })
            .store(in: &cancellables)
    }
}


// MARK: - SetupCardViewMode
extension SetupCardViewModel {
    enum SetupCardViewMode {
        case create
        case edit
        
        var navigationTitle: String {
            switch self {
                case .create:
                    return TextConstants.addCard
                case .edit:
                    return TextConstants.editCard
            }
        }
    }
}
