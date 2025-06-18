//
//  SetupCardView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 26/05/2025.
//

import SwiftUI
import Combine
import SwiftData

struct SetupCardView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var cardService: CardService
    @EnvironmentObject private var settings: SettingsService
    @EnvironmentObject private var filterService: FilterService
    @State private var showPopup = false
    @State private var showAlert = false
    @StateObject var viewModel: SetupCardViewModel
    @Binding  var showSetupCardView: Bool
    var onDismiss: ((Bool) -> Void)?
    
    var body: some View {
        List {
            Group {
                PhotoPickerView(viewModel: viewModel)
                
                if viewModel.showImageUrlSection {
                    Section(TextConstants.imageUrl) {
                        imageUrl
                    }
                }
                Section(TextConstants.phraseToRemember) {
                    phraseToRemember
                    translation
                    definition
                    transcription
                }
                Section(TextConstants.sources) {
                    sources
                }
            }
            .customListRow()
        }
        .customListStyle()
        .interactiveDismissDisabled(true)
        .alert(
            TextConstants.warning,
            isPresented: $showAlert,
            actions: {
                yesButton
                noButton
            },
            message: { Text(TextConstants.closeWithoutSavingHelp) }
        )
        .popup(isPresented: $showPopup) {
            CustomPopup(
                text: TextConstants.pasted,
                showPopup: $showPopup
            )
        }
        .navigationTitle(viewModel.mode.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) { saveButton }
            ToolbarItem(placement: .cancellationAction) { cancelButton }
        }
    }
    
    private var imageUrl: some View {
        TextFieldWithFlippableButton(
            text: $viewModel.url,
            error: viewModel.urlError,
            placeholder: TextConstants.addImageUrl,
            font: .system(size: 18, design: .monospaced),
            additionalButtonImage: Image(systemName: "square.and.arrow.down"),
            additionalAsyncButtonAction: { await viewModel.downloadImage() },
            pasteButtonAction: {
                viewModel.url = $0
                showPopup = true
            }
        )
    }
    
    private var phraseToRemember: some View {
        VStack {
            HighlightableTextView(
                text: $viewModel.phraseToRemember,
                placeholder: TextConstants.addPhrase,
                error: viewModel.phraseToRememberError
            ) {
                viewModel.formatAndSetPhrase($0, string: &viewModel.phraseToRemember)
                showPopup = true
            }
            if let languages = settings.languagesToStudy {
                Picker("", selection: $viewModel.phraseToRememberLanguage) {
                    ForEach(languages) { language in
                        Text(language.flagEmoji)
                            .tag(language)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
    
    private var translation: some View {
        HighlightableTextView(
            text: $viewModel.translation,
            placeholder: TextConstants.addTranslation,
            error: viewModel.translationError
        ) {
            viewModel.formatAndSetPhrase($0, string: &viewModel.translation)
            showPopup = true
        }
    }
    
    private var definition: some View {
        HighlightableTextView(
            text: $viewModel.definition,
            placeholder: TextConstants.addDefinition,
            error: viewModel.definitionError
        ) {
            viewModel.formatAndSetPhrase($0, string: &viewModel.definition)
            showPopup = true
        }
    }
    
    private var transcription: some View  {
        TextFieldWithFlippableButton(
            text: $viewModel.transcription,
            error: viewModel.transcriptionError,
            placeholder: TextConstants.addTranscription,
            font: .system(size: 18, design: .monospaced),
            pasteButtonAction: { text in
                withAnimation {
                    viewModel.transcription = text
                }
                showPopup = true
            }
        )
    }
    
    private var sources: some View {
        Group {
            AddNewSourceView(viewModel: viewModel)
            TagCloudView(viewModel: TagCloudViewModel(items: viewModel.sourcesTagCloudItems, isSelectable: true))
        }
    }
    
    private var yesButton: some View {
        Button(TextConstants.yes) {
            showSetupCardView = false
            onDismiss?(false)
        }
    }
    
    private var noButton: some View {
        Button(TextConstants.no, role: .cancel) { }
    }
    
    private var saveButton: some View {
        AsyncButton(
            isEnabled: viewModel.isSaveButtonEnabled,
            action: {
                hideKeyboard()
                await viewModel.saveCard(
                    context: context,
                    cardService: cardService,
                    settings: settings,
                    filterService: filterService
                )
                onDismiss?(true)
                showSetupCardView = false
            },
            label: {
                Text(TextConstants.save)
            }
        )
    }
    
    private var cancelButton: some View {
        Button(TextConstants.cancel) {
            if viewModel.wasChanged {
                showAlert = true
            } else {
                showSetupCardView = false
                onDismiss?(false)
            }
        }
    }
}
