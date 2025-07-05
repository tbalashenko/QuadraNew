//
//  DummyCardModel.swift
//  QuadraSD
//
//  Created by Tatyana Balashenko on 20/05/2025.
//

import Foundation

struct DummyCardModel {
    let item: DummyItem
}

// MARK: - Identifiable
extension DummyCardModel: Identifiable {
    var id: UUID { item.id }
}

// MARK: - Equatable
extension DummyCardModel: Equatable {
    static func == (lhs: DummyCardModel, rhs: DummyCardModel) -> Bool {
        lhs.id == rhs.id
    }
}
