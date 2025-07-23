//
//  StatViewModel.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 14/05/2024.
//

import Foundation

class StatViewModel: ObservableObject {
    @Published var showTotalNumber = false
    @Published var showAddedCards = true
    @Published var showRepeatedCards = true
    @Published var showDeletedCards = true
    @Published var showMemorizedCards = true
}
