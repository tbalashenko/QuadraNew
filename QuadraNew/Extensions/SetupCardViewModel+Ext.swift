//
//  SetupCardViewModel+Ext.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 28/05/2025.
//

import SwiftUI
import Combine
import SwiftData

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

// MARK: - Combine
extension SetupCardViewModel {
    func setupBindings() {
        setupUrl()
        setupPhraseToRemember()
        setupTranslation()
        setupTranscription()
        setupNewSourceText()
    }
    
    private func setupUrl() {
        $url
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                if value.isEmpty {
                    self?.urlError = ""
                }
            }
            .store(in: &cancellables)
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
                
                if isValid {
                    self.phraseToRememberError = ""
                } else {
                    Helper.getErrorMessage(for: self.phraseToRemember, errorText: &self.phraseToRememberError)
                }
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
                
                if isValid {
                    self.translationError = ""
                } else {
                    Helper.getErrorMessage(for: self.translation, errorText: &self.translationError)
                }
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
                
                if isValid {
                    self.transcriptionError = ""
                } else {
                    Helper.getErrorMessage(for: self.transcription, errorText: &self.transcriptionError)
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupNewSourceText() {
        $newSourceText
            .sink { [weak self] _ in
                self?.updateSourceTagCloudItems()
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
    
    func updateSourceTagCloudItems() {
        sourcesTagCloudItems = sources
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
    @MainActor
    func downloadImage() async {
        do {
            let data: Data = try await NetworkService.shared.fetch(urlString: url)
            
            guard let uiImage = UIImage(data: data) else {
                urlError = TextConstants.somethingWentWrong
                return
            }
            
            self.image = Image(uiImage: uiImage)
            self.croppedImage = Image(uiImage: uiImage)
            self.urlError = ""
        } catch let error as APIError {
            urlError = error.errorDescription
        } catch {
            urlError = TextConstants.failedToDownloadImage + error.localizedDescription
        }
    }
}

extension SetupCardViewModel {
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
    
    func makeCardInput(settings: SettingsService) -> CardInput {
        let scale = settings.imageScaleSetting
        let imageData = image?.convert(scale: scale)?.pngData()
        let croppedData = croppedImage?.convert(scale: scale)?.pngData()
        
        return CardInput(
            phrase: phraseToRemember,
            translation: translation,
            transcription: transcription,
            phraseToRememberLanguage: phraseToRememberLanguage.rawValue,
            translationLanguage: translationLanguage.rawValue,
            sources: selectedSources,
            imageData: imageData,
            croppedImageData: croppedData
        )
    }
}
