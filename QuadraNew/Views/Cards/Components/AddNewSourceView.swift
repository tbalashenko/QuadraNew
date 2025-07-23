//
//  AddNewSourceView.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 19/05/2025.
//


import SwiftUI
import SwiftData

struct AddNewSourceView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var viewModel: SetupCardViewModel
    
    var body: some View {
        HStack {
            ColorPicker("", selection: $viewModel.sourceColor)
                .northWestShadow()
                .labelsHidden()
            TextField(TextConstants.addSource, text: $viewModel.newSourceText)
                .textFieldStyle(NeuTextFieldStyle(text: $viewModel.newSourceText))
                .padding(.horizontal, 4)
            
            NeuButton(
                image: "plus",
                buttonSize: .m,
                imageSize: .small
            ) {
                viewModel.saveSource(context: context)
                hideKeyboard()
            }
            .disabled(viewModel.newSourceText.isEmpty)
        }
    }
}

#Preview {
    AddNewSourceView(viewModel: SetupCardViewModel(mode: .create, sources: []))
}
