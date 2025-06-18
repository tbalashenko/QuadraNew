//
//  CardsListView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 14/03/2024.
//

import SwiftUI
import Combine
import SwiftData

struct CardsListView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var filterService: FilterService
    @StateObject var viewModel: ListViewModel
    @Query private var allCards: [Card]
    @Query private var archiveTags: [ArchiveTag]
    @Query private var cardSources: [CardSource]
    
    init(viewModel: ListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
                        destination: { FilterView(viewModel: FilterViewModel(filterService: filterService)) },
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
                
                do {
                    try modelContext.save()
                } catch {
                    print("card delete error: \(error)")
                }
            }
        }
        
        update()
    }
    
    private func update() {
        filterService.setData(cards: allCards, archiveTags: archiveTags, cardSources: cardSources)
        viewModel.setData(cards: allCards)
    }
}
