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
    static let screenHeigh: CGFloat = UIScreen.main.bounds.height

    static let cornerRadius: CGFloat = 8
    static let spacing: CGFloat = 8
    static let mediumSpacing: CGFloat = 16
    static let bigSpacing: CGFloat = 32

    // MARK: - Buttons
    static let plainButtonSize = CGSize(width: buttonWith, height: buttonHeigh)
    static let buttonHeigh: CGFloat = 40.0
    static var buttonWith: CGFloat = UIScreen.main.bounds.width * 0.6
    static let smallButtonImageSize: CGSize = CGSize(width: 22, height: 22)
    static let mediumButtonImageSize: CGSize = CGSize(width: 38, height: 38)
    static let buttonPadding: CGFloat = 4
    static let horizontalPadding: CGFloat = 32
    static let listHorizontalPadding: CGFloat = 16
    
    // MARK: - Cards
    static var cardWith: CGFloat = UIScreen.main.bounds.width - 2 * horizontalPadding
    static var cardHeight: CGFloat = UIScreen.main.bounds.height * 0.7
    static var cardSize: CGSize = CGSize(width: cardWith, height: cardHeight)
    static var dummyCardSize: CGSize = CGSize(width: cardWith / 2, height: cardHeight / 2)

    static var screenCutOff: CGFloat = cardWith * 0.4

    @Published var ratio: CGFloat = AspectRatio.sixteenToNine.ratio
    
    @Published var imageWith: CGFloat = UIScreen.main.bounds.width - 2 * horizontalPadding
    @Published var imageHeigh: CGFloat = 0
    
    @Published var listImageHeigh: CGFloat = 88
    @Published var listImageWidth: CGFloat = 0
    @Published var listImageSize: CGSize = .zero
    
    @Published var listRowWidth: CGFloat = UIScreen.main.bounds.width - 16
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
        imageHeigh = imageWith * ratio
        listImageWidth = listImageHeigh / ratio
        imageSize = CGSize(width: imageWith, height: imageHeigh)
        listImageFullSize = CGSize(width: listRowWidth, height: listRowWidth * ratio)
        listImageSize = CGSize(width: listImageWidth, height: listImageHeigh)
    }
}
