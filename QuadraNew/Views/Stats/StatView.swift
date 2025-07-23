//
//  StatView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 17/04/2024.
//

import SwiftUI
import SwiftData

struct StatView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var statDataService: StatDataService
    @EnvironmentObject var randomDataService: RandomDataService
    @StateObject var viewModel = StatViewModel()
    @State private var selectedPeriod = Period.lastWeek
    @Query var statData: [StatData]

    private var toggleBindings: [Binding<Bool>] {
        [
            $viewModel.showTotalNumber,
            $viewModel.showAddedCards,
            $viewModel.showRepeatedCards,
            $viewModel.showMemorizedCards,
            $viewModel.showDeletedCards,
        ]
    }

    var body: some View {
        NavigationStack {
            Group {
                if statData.count < 3 {
                    StatEmptyView()
                } else {
                    ChartView(
                        selectedPeriod: $selectedPeriod,
                        toggleBindings: toggleBindings,
                        viewModel: viewModel
                    )
                }
            }
            .toolbar {
                ToolbarItem {
                    NeuButton(image: "plus.circle") {
                        randomDataService.addRandomData(in: context)
                    }
                }
            }
        }
    }
}

#Preview {
    StatView()
}
