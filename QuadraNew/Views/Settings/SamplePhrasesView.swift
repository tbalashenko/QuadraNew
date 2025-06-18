//
//  SamplePhrasesView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 10/06/2024.
//

import SwiftUI

struct SamplePhrasesView: View {
    @StateObject var viewModel = SamplePhrasesViewModel()
    @State private var showCopiedPopup = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading) {
                        TextFieldWithFlippableButton(
                            text: $viewModel.searchText,
                            error: viewModel.searchTextError,
                            placeholder: TextConstants.expressionToSearch,
                            font: .system(size: 18, weight: .bold),
                            additionalButtonImage: Image(systemName: "magnifyingglass.circle.fill"),
                            additionalAsyncButtonAction: { await viewModel.loadSamples() },
                            pasteButtonAction: {
                                viewModel.searchText = $0
                                showCopiedPopup = true
                            }
                        )
                        
                        FootnoteText(text: TextConstants.enterExpression)
                        
                        if viewModel.showError {
                            Text(TextConstants.noSamplePhrases)
                        }
                    }
                    ForEach(viewModel.samples, id: \.self) { sampleText in
                        HStack {
                            Text(sampleText)
                            Spacer()
                            CopyButton(text: sampleText) {
                                showCopiedPopup = true
                            }
                        }
                    }
                }
                .customListRow()
            }
            .customListStyle()
            .popup(isPresented: $showCopiedPopup) {
                CustomPopup(
                    text: TextConstants.copied,
                    showPopup: $showCopiedPopup
                )
            }
            .navigationTitle(TextConstants.getSample)
        }
        
    }
}

#Preview {
    SamplePhrasesView()
}
