//
//  AdditionalInfoView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 10/06/2025.
//

import SwiftUI

struct AdditionalInfoView: View {
    @ObservedObject var viewModel: CardViewModel

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(viewModel.additionalInfo, id: \.self) { info in
                        StyledText(description: info.description, value: info.value)
                    }
                }
                Spacer()
            }
            TagCloudView(
                viewModel: TagCloudViewModel(
                    items: viewModel.tags,
                    isSelectable: false
                )
            )
        }
        .padding(.horizontal)
    }
}
