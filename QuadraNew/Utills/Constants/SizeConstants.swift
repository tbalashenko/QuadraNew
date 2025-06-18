//
//  SizeConstants.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import Combine
import SwiftUI

final class SizeConstants: ObservableObject {
    
    static let textLimit = 200
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height

    static let cornerRadius: CGFloat = 8
    static let spacing: CGFloat = 8
    static let mediumSpacing: CGFloat = 16
    static let bigSpacing: CGFloat = 32

    // MARK: - Buttons
    static let plainButtonSize = CGSize(width: buttonWidth, height: buttonHeight)
    static let buttonHeight: CGFloat = 40.0
    static var buttonWidth: CGFloat = screenWidth * 0.6
    static let smallButtonImageSize: CGSize = CGSize(width: 24, height: 24)
    static let smallButtonSize: CGSize = CGSize(width: 24, height: 24)
    static let mediumButtonImageSize: CGSize = CGSize(width: 28, height: 28)
    static let mediumButtonSize: CGSize = CGSize(width: 28, height: 28)
    static let largeButtonSize: CGSize = CGSize(width: 44, height: 44)
    static let largeButtonImageSize: CGSize = CGSize(width: 44, height: 44)
    static let xLargeButtonSize: CGSize = CGSize(width: 120, height: 120)
    static let xLargeButtonImageSize: CGSize = CGSize(width: 120, height: 120)
    static let buttonPadding: CGFloat = 4
    static let horizontalPadding: CGFloat = 32
    static let listHorizontalPadding: CGFloat = 16
    
    // MARK: - Cards
    static var cardWidth: CGFloat = screenWidth - 2 * horizontalPadding
    static var cardHeight: CGFloat = screenHeight * 0.7
    static var cardSize: CGSize = CGSize(width: cardWidth, height: cardHeight)
    static var dummyCardSize: CGSize = CGSize(width: cardWidth / 2, height: cardHeight / 2)

    static var screenCutOff: CGFloat = cardWidth * 0.4

    @Published var ratio: CGFloat = AspectRatio.sixteenToNine.ratio
    
    @Published var imageWidth: CGFloat = screenWidth - 2 * horizontalPadding
    @Published var imageHeight: CGFloat = 0
    
    @Published var listImageHeigh: CGFloat = 88
    @Published var listImageWidth: CGFloat = 0
    @Published var listImageSize: CGSize = .zero
    
    @Published var listRowWidth: CGFloat = screenWidth - 16
    @Published var listImageFullSize: CGSize = .zero
    @Published var imageSize: CGSize = .zero

    private var cancellables = Set<AnyCancellable>()

    init(settings: SettingsService) {
        self.ratio = settings.aspectRatio.ratio
        
        recalculate()

        settings.$aspectRatio
            .sink { [weak self] newAspectRatio in
                guard let self = self else { return }
                self.ratio = newAspectRatio.ratio
                self.recalculate()
            }
            .store(in: &cancellables)
    }

    private func recalculate() {
        imageHeight = imageWidth * ratio
        listImageWidth = listImageHeigh / ratio
        imageSize = CGSize(width: imageWidth, height: imageHeight)
        listImageFullSize = CGSize(width: listRowWidth, height: listRowWidth * ratio)
        listImageSize = CGSize(width: listImageWidth, height: listImageHeigh)
    }
}
