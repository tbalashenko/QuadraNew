//
//  CardInput.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 06/06/2025.
//

import SwiftUI

struct CardInput {
    var phrase: AttributedString
    var translation: AttributedString
    var transcription: String
    var phraseToRememberLanguage: String
    var translationLanguage: String
    var sources: [CardSource]
    var imageData: Data?
    var croppedImageData: Data?
}
