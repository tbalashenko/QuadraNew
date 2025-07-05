//
//  TagCloudViewModel.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import Foundation

final class TagCloudViewModel: ObservableObject {
    @Published var displayedItems = [TagCloudItem]()
    @Published var items = [TagCloudItem]()

    let isSelectable: Bool
    private let max: Int?

    init(items: [TagCloudItem], isSelectable: Bool, max: Int? = nil) {
        self.items = items
        self.isSelectable = isSelectable
        self.max = max
        setupDisplayedItems()
    }

    func updateDisplayedItems() {
        displayedItems = displayedItems.sorted(by: { $0.isSelected && !$1.isSelected })
    }

    private func setupDisplayedItems() {
        if let max {
            displayedItems = Array(items.prefix(max))
        } else {
            displayedItems = items
        }
        displayedItems = displayedItems.sorted(by: { $0.isSelected && !$1.isSelected })
    }
}
