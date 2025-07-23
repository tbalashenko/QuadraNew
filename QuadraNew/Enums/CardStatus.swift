//
//  CardStatus.swift
//  Quadra
//
//  Created by Tatyana Balashenko on 19/03/2024.
//

import Foundation
import SwiftUI

enum CardStatus: Int, CaseIterable {
    case input = 0
    case nextDay = 1
    case day7 = 7
    case day30 = 30
    case day60 = 60
    case day90 = 90
    case archive
    
    init(_ rawValue: Int) {
        self = CardStatus(rawValue: rawValue) ?? .input
    }
    
    var title: String {
        switch self {
            case .input:
                TextConstants.input
            case .nextDay:
                TextConstants.nextDay
            case .day7:
                TextConstants.day7
            case .day30:
                TextConstants.day30
            case .day60:
                TextConstants.day60
            case .day90:
                TextConstants.day90
            case .archive:
                TextConstants.archive
        }
    }
    
    var color: Color {
        switch self {
            case .input:
                Color.Status.energyGreen0
            case .nextDay:
                Color.Status.energyGreen1
            case .day7:
                Color.Status.energyGreen2
            case .day30:
                Color.Status.energyGreen3
            case .day60:
                Color.Status.energyGreen4
            case .day90:
                Color.Status.energyGreen5
            case .archive:
                Color.spanishGray
        }
    }
}

// MARK: - Identifiable
extension CardStatus: Identifiable {
    var id: Int { self.rawValue }
}
