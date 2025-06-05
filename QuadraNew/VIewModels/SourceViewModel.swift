//
//  SourceViewModel.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 15/05/2024.
//

import Foundation
import SwiftData
import SwiftUI

final class SourceViewModel: ObservableObject {
    @Environment(\.modelContext) var modelContext
    @Published var source: CardSource
    @Published var editableTitle: String = ""
    @Published var compoundTitle: String = ""
    @Published var color: String = ""
    private var titleCopy: String = ""
    
    @Query var sources: [CardSource]

    init(source: CardSource) {
        self.source = source
        self.editableTitle = source.title
        self.titleCopy = source.title
        self.compoundTitle = getTitle(for: source)
        self.color = source.color
    }

    func saveChanges() {
        source.title = editableTitle
        source.color = color
        
        try? modelContext.save()
        
        titleCopy = source.title
        compoundTitle = getTitle(for: source)
    }
    
    func resetChanges() {
        editableTitle = titleCopy
    }
    
    /// Generates a title for the source based on the count of cards.
    /// - Parameter source: The card source.
    /// - Returns: The formatted title string.
    private func getTitle(for source: CardSource) -> String {
        let cardsCount = source.cards.count
        
        switch cardsCount {
            case 0:
                return "\(source.title) - \(TextConstants.noCards)"
            case 1:
                return "\(source.title) - \(TextConstants.oneCard)"
            default:
                return "\(source.title) - \(cardsCount) \(TextConstants.cards)"
        }
    }
}
