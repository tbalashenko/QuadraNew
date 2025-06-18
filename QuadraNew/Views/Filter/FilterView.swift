//
//  FilterView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 27/03/2024.
//

import SwiftUI
import Combine
import SwiftData

struct FilterView: View {
    @EnvironmentObject var filterService: FilterService    
    @StateObject var viewModel: FilterViewModel
    @Query private var cards: [Card]
    @Query private var archiveTags: [ArchiveTag]
    @Query private var cardSources: [CardSource]
    
    init(viewModel: FilterViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
                filterService.reset()
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
