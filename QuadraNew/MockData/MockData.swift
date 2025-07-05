//
//  MockData.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

struct MockData {
    static var cards: [Card] = [
        
    ]
    
    static let mockedCards: [DummyItem] = [
        DummyItem(title: "Hello, world", image: Image("hello-world")),
        DummyItem(title: "Let's call it a day", image: Image("lets-call-it-a-day")),
        DummyItem(title: "Take your time", image: Image("take-your-time")),
        DummyItem(title: "Oh, never mind", image: Image("oh-never-mind")),
        DummyItem(title: "That sounds great", image: Image("that-sounds-great"))
    ]
    
    static let tagCloudItems: [TagCloudItem] = [
        TagCloudItem(
            isSelected: true,
            id: UUID(),
            title: "Test",
            color: .slateGray),
        TagCloudItem(
            isSelected: true,
            id: UUID(),
            title: "Testhfiuewhfiueh",
            color: .green),
        TagCloudItem(
            isSelected: true,
            id: UUID(),
            title: "Testofjeiuhfj",
            color: .green),
        TagCloudItem(
            isSelected: true,
            id: UUID(),
            title: "Testojhuhhuuuuuu",
            color: .green),
        TagCloudItem(
            isSelected: true,
            id: UUID(),
            title: "Testoheuiwhfiuehf",
            color: .green)
    ]
}
