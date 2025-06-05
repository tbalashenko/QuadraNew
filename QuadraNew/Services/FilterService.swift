//
//  FilterService.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 05/07/2025.
//

import Combine
import Foundation

final class FilterService: ObservableObject {
    static let shared = FilterService()
    
    @Published var selectedStatuses = CardStatus.allCases
    @Published var selectedSources = [CardSource]()
    @Published var selectedArchiveTags = [ArchiveTag]()
    @Published var fromDate = Date()
    @Published var toDate = Date()
    @Published var minDate = Date()
    @Published var maxDate = Date()
    
    @Published var allCards = [Card]()
    @Published var allArchiveTags = [ArchiveTag]()
    @Published var allCardSources = [CardSource]()
    
    var wasInitiallySet = false
    
    func setData(cards: [Card], archiveTags: [ArchiveTag], cardSources: [CardSource]) {
        self.allCards = cards
        self.allArchiveTags = archiveTags
        self.allCardSources = cardSources
        
        if !wasInitiallySet {
            wasInitiallySet.toggle()
            self.selectedArchiveTags = archiveTags
        }
        
        setupDates()
    }
    
    func reset() {
        selectedStatuses = CardStatus.allCases
        selectedSources = allCardSources
        selectedArchiveTags = allArchiveTags
        setupDates()
        wasInitiallySet = false
    }
    
    func setupDates() {
        fromDate = allCards.map{ $0.creationDate }.min() ?? Date().addingTimeInterval(-1)
        toDate = allCards.map{ $0.creationDate }.max() ?? Date().addingTimeInterval(1)
        minDate = allCards.map{ $0.creationDate }.min() ?? Date()
        maxDate = allCards.map{ $0.creationDate }.max() ?? Date()
    }
    
    func toggleStatusSelection(status: CardStatus) {
        toggleItem(item: status, in: &selectedStatuses)
    }
    
    func toggleArchiveTagSelection(tag: ArchiveTag) {
        toggleItem(item: tag, in: &selectedArchiveTags)
    }
    
    func toggleSourceSelection(source: CardSource) {
        toggleItem(item: source, in: &selectedSources)
    }
    
    private func toggleItem<T: Equatable & Identifiable>(item: T, in array: inout [T]) {
        if let index = array.firstIndex(where: { $0.id == item.id }) {
            array.remove(at: index)
        } else {
            array.append(item)
        }
    }
}
