//
//  FlippableCardView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 17/06/2025.
//

import SwiftUI

struct FlippableCardView: View {
    @ObservedObject var viewModel: CardViewModel
    
    var body: some View {
        FlippableView {
            CardFrontView(viewModel: viewModel)
        } back: {
            CardBackView(viewModel: viewModel)
        }
    }
}
