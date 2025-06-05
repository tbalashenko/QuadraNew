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
    @StateObject var viewModel: SetupCardViewModel
    @State private var showPopup = false
    @State private var showAlert = false
    @Binding var showSetupCardView: Bool
    var onDismiss: ((Bool) -> Void)?
    
    var body: some View {
        List {
            Group {
                PhotoPickerView(viewModel: viewModel)
                imageUrlSection()
                phraseToRememberSection()
                translationSection()
                transcriptionSection()
                sourcesSection()
            }
            .customListRow()
        }
        .interactiveDismissDisabled(true)
        .alert(
            TextConstants.warning,
            isPresented: $showAlert,
            actions: { alertActions() },
            message: { Text(TextConstants.closeWithoutSavingHelp) }
        )
        .popup(isPresented: $showPopup) {
            CustomPopup(
                text: TextConstants.pasted,
                showPopup: $showPopup
            )
        }
        .customListStyle()
        .navigationTitle(viewModel.mode.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) { saveButton() }
            ToolbarItem(placement: .cancellationAction) { cancelButton() }
        }
    }
    
    @ViewBuilder
    private func imageUrlSection() -> some View {
        if viewModel.showImageUrlSection {
            Section(TextConstants.imageUrl) {
                TextFieldWithFlippableButton(
                    text: $viewModel.url,
                    error: viewModel.urlError,
                    additionalButtonImage: Image(systemName: "square.and.arrow.down"),
                    additionalButtonAction: { viewModel.downloadImage() },
                    pasteButtonAction: {
                        viewModel.url = $0
                        showPopup = true
                    }
                )
            }
        }
    }
    
    @ViewBuilder
    private func phraseToRememberSection() -> some View {
        Section(TextConstants.phraseToRemember) {
            HighlightableTextView(text: $viewModel.phraseToRemember, error: viewModel.phraseToRememberError) {
                viewModel.formatAndSetPhrase($0, string: &viewModel.phraseToRemember)
                showPopup = true
            }
        }
    }
    
    @ViewBuilder
    private func translationSection() -> some View {
        Section(TextConstants.translation) {
            HighlightableTextView(text: $viewModel.translation, error: viewModel.translationError) {
                viewModel.formatAndSetPhrase($0, string: &viewModel.translation)
                showPopup = true
            }
        }
    }
    
    @ViewBuilder
    private func transcriptionSection() -> some View {
        Section(TextConstants.transcription) {
            TextFieldWithFlippableButton(
                text: $viewModel.transcription,
                error: viewModel.transcriptionError,
                pasteButtonAction: { text in
                    withAnimation {
                        viewModel.transcription = text
                    }
                    showPopup = true
                }
            )
        }
    }
    
    private func sourcesSection() -> some View {
        Section(TextConstants.sources) {
            AddNewSourceView(viewModel: viewModel)
            TagCloudView(viewModel: TagCloudViewModel(items: viewModel.tagCloudItems, isSelectable: true))
        }
    }
    
    @ViewBuilder
    private func alertActions() -> some View {
        Button(TextConstants.yes) {
            showSetupCardView = false
            onDismiss?(false)
        }
        Button(TextConstants.no, role: .cancel) { }
    }
    
    private func saveButton() -> some View {
        Button(TextConstants.save) {
            hideKeyboard()
            viewModel.saveCard(context: context)
            showSetupCardView = false
            onDismiss?(true)
        }
        .disabled(viewModel.isSaveButtonDisabled)
    }
    
    private func cancelButton() -> some View {
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
