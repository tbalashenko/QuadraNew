//
//  SamplePhrasesViewModel.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 10/06/2024.
//

import Foundation
import Combine

@MainActor
final class SamplePhrasesViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchTextError: String = ""
    @Published var samples = [String]()
    @Published var showError: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let textLimit = 30

    init() {
        $searchText
            .sink { [weak self] value in
                guard let self else { return }
                
                if value.replacingOccurrences(of: " ", with: "").isEmpty {
                    samples.removeAll()
                    showError = false
                }
                
                Helper.getErrorMessage(for: value, errorText: &searchTextError, textLimit: textLimit)
            }
            .store(in: &cancellables)
    }

    func loadSamples() async {
        samples.removeAll()
        let prompt = String(format: TextConstants.aiSamplePrompt, searchText)
        
        let aiSamples = await AIService.shared.getAIResponse(prompt: prompt)
        samples = aiSamples.components(separatedBy: "\n")
    }
}
