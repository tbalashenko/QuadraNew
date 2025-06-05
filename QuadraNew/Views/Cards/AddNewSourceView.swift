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
            Button(action: {
                viewModel.saveSource(context: context)
                hideKeyboard()
            }, label: {
                Image(systemName: "plus")
            })
            .buttonStyle(NeuButtonStyle(size: SizeConstants.mediumButtonImageSize))
            .disabled(viewModel.newSourceText.isEmpty)
        }
    }
}
