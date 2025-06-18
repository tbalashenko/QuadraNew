//
//  FilterViewModel.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 18/06/2025.
//

import Combine
import SwiftUI

final class FilterViewModel: ObservableObject {
    @Published var statusTags: [TagCloudItem] = []
    @Published var archiveTags: [TagCloudItem] = []
    @Published var sourceTags: [TagCloudItem] = []
    @Published var allCards = [Card]()
    @Published var allArchiveTags = [ArchiveTag]()
    @Published var allCardSources = [CardSource]()
    
#warning("Add info view")
    @Published var showInfoView: Bool = false
    var filterService: FilterService
    var cancellables: Set<AnyCancellable> = []
    
    init(filterService: FilterService) {
        self.filterService = filterService
        setupStatusTags()
        setupBindings()
    }
    
    func setupBindings() {
        $allCards
            .receive(on: RunLoop.main)
            .map { $0.isEmpty }
            .assign(to: \.showInfoView, on: self)
            .store(in: &cancellables)
        $allArchiveTags
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.setupArchiveTags()
            }
            .store(in: &cancellables)
        $allCardSources
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.setupSourceTags()
            }
            .store(in: &cancellables)
    }
    
    func resetFilter() {
        filterService.reset()
        setupStatusTags()
        setupArchiveTags()
        setupSourceTags()
    }
    
    private func setupStatusTags() {
        statusTags.removeAll()
        
        CardStatus.allCases.forEach { status in
            let item = TagCloudItem(
                isSelected: filterService.selectedStatuses.contains(status),
                id: UUID(uuidString: String(status.id)) ?? UUID(),
                title: status.title,
                color: status.color,
                action: {
                    self.filterService.toggleStatusSelection(status: status)
                }
            )
            statusTags.append(item)
        }
    }
    
    private func setupArchiveTags() {
        archiveTags.removeAll()
        
        allArchiveTags.forEach { tag in
            let item = TagCloudItem(
                isSelected: filterService.selectedArchiveTags.contains(tag),
                id: tag.id,
                title: tag.title,
                color: Color(hex: tag.color),
                action: {
                    self.filterService.toggleArchiveTagSelection(tag: tag)
                }
            )
            archiveTags.append(item)
        }
    }
    
    private func setupSourceTags() {
        sourceTags.removeAll()
        
        allCardSources.forEach { source in
            let item = TagCloudItem(
                isSelected: filterService.selectedSources.contains(source),
                id: source.id,
                title: source.title,
                color: Color(hex: source.color),
                action: {
                    self.filterService.toggleSourceSelection(source: source)
                }
            )
            sourceTags.append(item)
        }
    }
    
    func setData(cards: [Card], archiveTags: [ArchiveTag], cardSources: [CardSource]) {
        self.allCards = cards
        self.allArchiveTags = archiveTags
        self.allCardSources = cardSources
    }
}
