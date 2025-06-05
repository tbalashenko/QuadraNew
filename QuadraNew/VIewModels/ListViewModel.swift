//
//  ListViewModel.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 05/07/2025.
//

import SwiftUI
import Combine
import SwiftData

final class ListViewModel: ObservableObject {
    @ObservedObject var filterService = FilterService.shared
    @Published var cards: [Card] = []
    @Published var searchText: String = ""
    @Published var filteredCards: [CardStatus: [Card]] = [:]
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupBindings()
    }
    
    func setData(cards: [Card]){
        self.cards = cards
    }
    
    func setupBindings() {
        filterService.$selectedStatuses
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterCards()
            }
            .store(in: &cancellables)
        filterService.$selectedArchiveTags
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterCards()
            }
            .store(in: &cancellables)
        filterService.$selectedSources
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterCards()
            }
            .store(in: &cancellables)
        filterService.$fromDate
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterCards()
            }
            .store(in: &cancellables)
        filterService.$toDate
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterCards()
            }
            .store(in: &cancellables)
        $searchText
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterCards()
            }
            .store(in: &cancellables)
        $cards
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterCards()
            }
            .store(in: &cancellables)
    }
    
    func filterCards() {
        let filteredCards = cards
            .filter { card in
                let textMatch = self.checkTextMatch(card: card)
                let statusMatches = self.checkStatusMatches(card: card)
                let sourceMatches = self.checkSourceMatches(card: card)
                let dateRangeMatches = self.checkDateRangeMatches(card: card)
                let archiveTagMatches = self.checkArchiveTagMatches(card: card)
                return textMatch && statusMatches && sourceMatches && dateRangeMatches && archiveTagMatches
            }
        
        let newFilteredCards = Dictionary(grouping: filteredCards, by: { CardStatus($0.cardStatus) })
        
        if !self.filteredCards.isEqual(to: newFilteredCards) {
            self.filteredCards = newFilteredCards
        }
    }
}

extension ListViewModel {
    private func checkTextMatch(card: Card) -> Bool {
        if searchText.isEmpty || card.phraseToRemember.string.lowercased().contains(searchText.lowercased()) {
            return true
        } else if let translation = card.translation?.string {
            return translation.lowercased().contains(self.searchText.lowercased())
        }
        return false
    }

    private func checkStatusMatches(card: Card) -> Bool {
        if FilterService.shared.selectedStatuses == CardStatus.allCases || FilterService.shared.selectedStatuses.isEmpty {
            return true
        } else {
            return FilterService.shared.selectedStatuses.map { $0.id }.contains(card.cardStatus)
        }
    }

    private func checkSourceMatches(card: Card) -> Bool {
        guard !FilterService.shared.selectedSources.isEmpty else { return true }

        guard let sources = card.cardSources else { return false }

        let selectedIDs = Set(FilterService.shared.selectedSources.map { $0.id })
        return sources.contains { selectedIDs.contains($0.id) }
    }

    private func checkDateRangeMatches(card: Card) -> Bool {
        let fromDateComparison = Calendar.current.compare(FilterService.shared.fromDate, to: card.creationDate, toGranularity: .day)
        let toDateComparison = Calendar.current.compare(FilterService.shared.toDate, to: card.creationDate, toGranularity: .day)
        return fromDateComparison != .orderedDescending && toDateComparison != .orderedAscending
    }

    private func checkArchiveTagMatches(card: Card) -> Bool {
        if FilterService.shared.selectedArchiveTags.isEmpty {
            return true
        } else if let archiveTag = card.archiveTag {
            return FilterService.shared.selectedArchiveTags.contains(archiveTag)
        }

        return false
    }
}
