//
//  SourceListRow.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 12/04/2024.
//

import SwiftUI

struct SourceListRowView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject var viewModel: SourceViewModel
    @State var isEditing = false

    var body: some View {
        HStack(alignment: .center) {
            ColorPicker("", selection: Binding<Color>(
                get: { Color(hex: viewModel.color) },
                set: {
                    viewModel.color = $0.toHex()
                    viewModel.saveChanges(modelContext: modelContext)
                }
            ))
            .labelsHidden()
            .northWestShadow()

            if isEditing {
                HStack(spacing: 12) {
                    TextField("", text: $viewModel.editableTitle)
                        .textFieldStyle(NeuTextFieldStyle(text: $viewModel.editableTitle))
                    
                    Spacer()
                    
                    SmallButton(
                        image: "checkmark.circle.fill",
                        withBackground: false,
                        foregroundStyle: viewModel.editableTitle.isEmpty
                            ? .Green.isabelline
                            : .Green.darkSeaGreen
                    ) {
                        viewModel.saveChanges(modelContext: modelContext)
                        isEditing = false
                    }
                    .disabled(viewModel.editableTitle.isEmpty)
                    
                    SmallButton(
                        image: "xmark.circle.fill",
                        withBackground: false,
                        foregroundStyle: .puce
                    ) {
                        isEditing = false
                        viewModel.resetChanges()
                    }
                }
            } else {
                Text(viewModel.compoundTitle)
                    .onTapGesture { isEditing = true }
                Spacer()
            }

        }
        .padding()
        .background(
            Color.element
            .clipShape(RoundedRectangle(cornerRadius: SizeConstants.cornerRadius))
            .northWestShadow()
        )
        .customListRow()
    }
}

#Preview {
    let sources: [CardSource] = [
        CardSource(
            title: "Test1",
            color: Color.blue.toHex()
        ),
        CardSource(
            title: "Test2",
            color: Color.blue.toHex()
        ),
        CardSource(
            title: "Test3",
            color: Color.blue.toHex()
        ),
        CardSource(
            title: "Test4",
            color: Color.blue.toHex()
        )
    ]
    
    List {
        ForEach(sources) { source in
            SourceListRowView(viewModel: SourceViewModel(source: source))
        }
    }
    .customListStyle()
    
    
//    SourceListRowView(
//        viewModel: SourceViewModel(
//            source: CardSource(
//                title: "Test",
//                color: Color.blue.toHex()
//            )
//        )
//    )
}
