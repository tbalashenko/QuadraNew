//
//  FilterView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 27/03/2024.
//

import SwiftUI
import Combine
import SwiftData

final class FilterViewModel: ObservableObject {
    @Published var statusTags: [TagCloudItem] = []
    @Published var archiveTags: [TagCloudItem] = []
    @Published var sourceTags: [TagCloudItem] = []
    @Published var allCards = [Card]()
    @Published var allArchiveTags = [ArchiveTag]()
    @Published var allCardSources = [CardSource]()
    
    @Published var showInfoView: Bool = false
    @ObservedObject var filterService = FilterService.shared
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
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


struct FilterView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = FilterViewModel()
    @ObservedObject var filterService = FilterService.shared
    @Query private var cards: [Card]
    @Query private var archiveTags: [ArchiveTag]
    @Query private var cardSources: [CardSource]
    
    
    var body: some View {
        List {
            if viewModel.showInfoView {
                Text("Add cards")
            } else {
                Section(TextConstants.status) {
                    filterTagCloudView(items: viewModel.statusTags)
                        .customListRow()
                }
                Section(TextConstants.creationDate) {
                    CreationDateView()
                        .customListRow()
                }
                Section(TextConstants.archiveTags) {
                    filterTagCloudView(items: viewModel.archiveTags)
                        .customListRow()
                }
                if !viewModel.sourceTags.isEmpty {
                    Section(TextConstants.sources) {
                        filterTagCloudView(items: viewModel.sourceTags)
                            .customListRow()
                    }
                }
            }
        }
        .onAppear {
            viewModel.setData(cards: cards, archiveTags: archiveTags, cardSources: cardSources)
        }
        .customListStyle()
        .navigationTitle(TextConstants.filter)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            Button {
                viewModel.resetFilter()
            } label: {
                Text(TextConstants.reset)
            }
        }
    }
    
    @ViewBuilder
    func filterTagCloudView(items: [TagCloudItem]) -> some View {
        TagCloudView(
            viewModel: TagCloudViewModel(
                items: items,
                isSelectable: true
            )
        )
    }
}
