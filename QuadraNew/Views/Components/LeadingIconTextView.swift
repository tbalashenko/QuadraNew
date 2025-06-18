//
//  LeadingIconTextView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 17/06/2025.
//

import SwiftUI

final class LeadingIconTextViewModel : ObservableObject {
    @Published var text: AttributedString = ""
    
    init(text: AttributedString) {
        self.text = text
    }
}


struct LeadingIconTextView<Leading: View>: View {
    @ObservedObject var viewModel: LeadingIconTextViewModel
    let leadingView: Leading?
    
    init(
        viewModel: LeadingIconTextViewModel,
        @ViewBuilder leadingView: () -> Leading?
    ) {
        self.viewModel = viewModel
        self.leadingView = leadingView()
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: SizeConstants.spacing) {
            leadingView
                .alignmentGuide(.firstTextBaseline) { d in
                    d[VerticalAlignment.center] + 8
                }
            
            Text(viewModel.text)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
        .background(Color.element)
    }
}
