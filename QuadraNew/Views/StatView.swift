//
//  StatView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 17/04/2024.
//

import SwiftUI
import SwiftData

struct StatView: View {
    @StateObject var viewModel = StatViewModel()

    @State private var selectedPeriod = Period.lastWeek

    private var toggleBindings: [Binding<Bool>] {
        [
            $viewModel.showTotalNumber,
            $viewModel.showAddedCards,
            $viewModel.showDeletedCards,
            $viewModel.showRepeatedCards
        ]
    }
    
    @Query var statData: [StatData]

    var body: some View {
        NavigationStack {
            if statData.isEmpty {
                StatEmptyView()
            }
//            if StatDataService.shared.statData.count < 3 {
//                StatEmptyView()
//            } else {
//                ChartView(
//                    selectedPeriod: $selectedPeriod,
//                    toggleBindings: toggleBindings,
//                    viewModel: viewModel)
//            }
        }
    }
}

#Preview {
    StatView()
}
