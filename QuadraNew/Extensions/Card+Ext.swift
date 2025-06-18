//
//  Card.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//
import SwiftUI

extension Card {
    // MARK: - Properties
    var convertedPhraseToRemember: AttributedString {
        AttributedString(phraseToRemember)
    }
    
    var isImageDark: Bool? {
        guard
            let imageData = croppedImageData,
            let uiImage = UIImage(data: imageData),
            let uiColor = uiImage.averageColor
        else { return nil }
        
        return Color(uiColor).isDark
    }
    
    
    var isReadyToRepeat: Bool {
        Date() >= nextReviewDate
    }
    
    /// - Throughout the day (several times since new phrases were added) →  inbox
    /// - In the morning (after one full night's sleep) → nextDay
    /// - After a week →  this month
    /// - One month later
    /// - After three months
    /// - Six months later
    /// - One year later
    /// - archive
    func setNextReviewDate(swipeSide: SwipeAction) {
        guard swipeSide == .right else {
            nextReviewDate = Date().addingTimeInterval(60 * 60 * 24)
            return
        }
        
        switch CardStatus(cardStatus) {
                //review in 5 minutes
            case .input:
                nextReviewDate = Date().addingTimeInterval(60 * 5)
                // review in 1 day
            case .nextDay:
                nextReviewDate = Date().addingTimeInterval(60 * 60 * 24)
                // review in +-7 days since addition
            case .day7:
                nextReviewDate = Date().addingTimeInterval(60 * 60 * 24 * 6)
                // review in +-30 days since addition
            case .day30:
                nextReviewDate = Date().addingTimeInterval(60 * 60 * 24 * 21)
                // review in +-60, 90 days since addition
            case .day60, .day90:
                nextReviewDate = Date().addingTimeInterval(60 * 60 * 24 * 30)
                // in a year
            case .archive:
                nextReviewDate = Date().addingTimeInterval(60 * 60 * 24 * 365)
        }
    }
    
    func setNewStatus(swipeSide: SwipeAction) {
        guard swipeSide == .right else { return }
        
        let status = CardStatus(cardStatus)
        
        guard status != .archive else { return }
        
        switch status {
            case .input:
                if Date().daysAgo(from: creationDate) > 0, repetitionCounter > 0 {
                    cardStatus = CardStatus.nextDay.rawValue
                }
            case .nextDay, .day7, .day30, .day60, .day90:
                cardStatus = status.next().rawValue
            default:
                break
        }
    }
}
