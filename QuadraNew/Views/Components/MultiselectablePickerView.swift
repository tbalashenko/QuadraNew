//
//  MultiselectablePickerView.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 11/06/2025.
//

import SwiftUI


struct MultiselectablePickerView<T: CaseIterable & Identifiable & Equatable & Hashable>: View where T.AllCases: RandomAccessCollection {
    @Binding var selectedItems: [T]
    let withMultipleSelection: Bool
    let navigationTitle: String
    let getTitle: (T) -> String

    var body: some View {
        List {
            ForEach(T.allCases.sorted(by: { getTitle($0) < getTitle($1) }), id: \.self) { item in
                MultipleSelectionRow(
                    item: item,
                    isSelected: selectedItems.contains(item),
                    titleProvider: getTitle,
                    action: { toggle(item) })
            }
            .listRowBackground(Color.element)
        }
        .customListStyle()
        .navigationTitle(navigationTitle)
    }

    private func toggle(_ item: T) {
        if withMultipleSelection {
            if selectedItems.contains(item) {
                selectedItems.removeAll { $0 == item }
            } else {
                selectedItems.append(item)
            }
        } else {
            selectedItems = [item]
        }
    }
}

#Preview {
//    LanguagePickerView(viewModel: SettingsViewModel(settings: SettingsService()), withMultipleSelection: true)
}
