//
//  DummyAutoswipingCardView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 01/06/2025.
//

import SwiftUI

struct DummyAutoswipingCardView: View {
    @StateObject var viewModel = DummyCardsViewModel()
    
    var body: some View {
        ZStack {
            DummyCardStackView(viewModel: viewModel)
            
            if viewModel.cardModels.isEmpty {
                RepeatButton { viewModel.updateCardModels() }
            } else {
                ArrowView()
            }
        }
    }
}


