//
//  ListView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 14/03/2024.
//

import SwiftUI
import Combine
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var filterService = FilterService.shared
    @StateObject var viewModel = ListViewModel()
    @Query private var allCards: [Card]
    @Query private var archiveTags: [ArchiveTag]
    @Query private var cardSources: [CardSource]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(CardStatus.allCases) { status in
                    if let cards = viewModel.filteredCards[status] {
                        Section(header: Text(status.title)) {
                            ForEach(cards) { card in
                                ListRowView(cardViewModel: CardViewModel(card: card, mode: .view))
                                    .customListRow()
                            }
                            .onDelete { indexSet in
                                deleteCard(status: status, offset: indexSet)
                            }
                        }
                    }
                }
            }
            .onAppear { update() }
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .automatic)
            )
            .customListStyle()
            .navigationTitle(TextConstants.yourPhrases)
            .toolbar(.visible, for: .tabBar)
            .toolbar {
                ToolbarItem {
                    NavigationLinkWithImage(
                        destination: { FilterView() },
                        image: "line.3.horizontal.decrease.circle.fill"
                    )
                }
            }
        }
    }
    
    private func deleteCard(status: CardStatus, offset: IndexSet) {
        withAnimation {
            for index in offset {
                guard
                    let card = viewModel.filteredCards[status]?[index],
                    let sdCard = allCards.first(where: { $0.id == card.id })
                else { return }
                
                modelContext.delete(sdCard)
                
                try? modelContext.save()
            }
        }
        
        update()
    }
    
    private func update() {
        filterService.setData(cards: allCards, archiveTags: archiveTags, cardSources: cardSources)
        viewModel.setData(cards: allCards)
    }
}
