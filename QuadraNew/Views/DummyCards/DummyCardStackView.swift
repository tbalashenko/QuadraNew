//
//  DummyCardStackView.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 08/05/2024.
//

import SwiftUI

struct DummyCardStackView: View {
    @ObservedObject var viewModel: DummyCardsViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            ForEach(viewModel.cardModels) { model in
                DummyCardView(
                    viewModel: viewModel,
                    model: model
                )
            }
        }
        .frame(size: SizeConstants.dummyCardSize)
    }
}

#Preview {
    DummyCardStackView(viewModel: DummyCardsViewModel())
        .frame(size: SizeConstants.cardSize)
}
