//
//  Settings.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 03/04/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsService
    @Environment(\.dismiss) private var dismiss    
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Group {
                    Section(TextConstants.languages) {
                        NavigationLink(TextConstants.selectLanguages) {
                            MultiselectablePickerView(
                                selectedItems: $viewModel.languagesToStudy,
                                withMultipleSelection: true,
                                navigationTitle: TextConstants.selectLanguages,
                                getTitle: { "\($0.flagEmoji) \($0.title)" }
                            )
                        }
                        FootnoteText(text: TextConstants.selectLanguagesToStudy)
                    }
                    
                    if viewModel.showVoicesSection {
                        Section(TextConstants.voices) {
                            VoicePickerView(viewModel: viewModel)
                        }
                    }
                    
                    Section(TextConstants.images) {
                        ImageSettingsView(viewModel: viewModel)
                    }
                    Section(TextConstants.animation) {
                        Toggle(TextConstants.showConfetti, isOn: $viewModel.showConfetti)
                        Toggle(TextConstants.showProgress, isOn: $viewModel.showProgress)
                    }
                    Section(TextConstants.manageSources) {
                        NavigationLink(TextConstants.sources) {
                            SourcesView()
                        }
                    }
                    Section(TextConstants.textFormatting) {
                        HighlighterPaletteView(viewModel: viewModel)
                    }
                    
                    Section(TextConstants.notifications) {
                        NotificationsView(viewModel: viewModel)
                    }
                }
                .listRowBackground(Color.dynamicGray)
            }
            .scrollContentBackground(.hidden)
            .background(Color.element)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(TextConstants.save) {
                        viewModel.save()
                        dismiss()
                    }
                }
            }
            .onAppear {
                viewModel.checkNotificationPermission()
            }
//            .onDisappear {
//                viewModel.setup()
//            }
            .toolbar(.hidden, for: .tabBar)
            .navigationBarTitle(TextConstants.settings)
        }
    }
}

#Preview {
    //SettingsView(viewModel: SettingsViewModel())
}
