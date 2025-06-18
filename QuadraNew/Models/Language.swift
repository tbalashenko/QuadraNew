//
//  Language.swift
//  QuadraNew
//
//  Created by Tatyana Balashenko on 11/06/2025.
//

import Foundation

enum Language: String, CaseIterable, Identifiable {
    case english
    case spanish
    case chinese
    case french
    case arabic
    case russian
    case portuguese
    case german
    case hindi
    case japanese
    case korean
    case italian
    case polish
    case turkish
    case dutch
    case czech
    case danish
    case greek
    case finnish
    case hebrew
    case hungarian
    case indonesian
    case norwegian
    case romanian
    case slovak
    case swedish
    case thai
    
    var id: String { rawValue }
    
    var title: String {
        rawValue.capitalized
    }
    
    var code: String {
        switch self {
            case .english: "en"
            case .spanish: "es"
            case .chinese: "zh"
            case .french: "fr"
            case .arabic: "ar"
            case .russian: "ru"
            case .portuguese: "pt"
            case .german: "de"
            case .hindi: "hi"
            case .japanese: "ja"
            case .korean: "ko"
            case .italian: "it"
            case .polish: "pl"
            case .turkish: "tr"
            case .dutch: "nl"
            case .czech: "cs"
            case .danish: "da"
            case .greek: "el"
            case .finnish: "fi"
            case .hebrew: "he"
            case .hungarian: "hu"
            case .indonesian: "id"
            case .norwegian: "no"
            case .romanian: "ro"
            case .slovak: "sk"
            case .swedish: "sv"
            case .thai: "th"
        }
    }
    
    var flagEmoji: String {
        switch self {
            case .english: "🇺🇸"
            case .spanish: "🇪🇸"
            case .chinese: "🇨🇳"
            case .french: "🇫🇷"
            case .arabic: "🇸🇦"
            case .russian: "🇷🇺"
            case .portuguese: "🇵🇹"
            case .german: "🇩🇪"
            case .hindi: "🇮🇳"
            case .japanese: "🇯🇵"
            case .korean: "🇰🇷"
            case .italian: "🇮🇹"
            case .polish: "🇵🇱"
            case .turkish: "🇹🇷"
            case .dutch: "🇳🇱"
            case .czech: "🇨🇿"
            case .danish: "🇩🇰"
            case .greek: "🇬🇷"
            case .finnish: "🇫🇮"
            case .hebrew: "🇮🇱"
            case .hungarian: "🇭🇺"
            case .indonesian: "🇮🇩"
            case .norwegian: "🇳🇴"
            case .romanian: "🇷🇴"
            case .slovak: "🇸🇰"
            case .swedish: "🇸🇪"
            case .thai: "🇹🇭"
        }
    }
    
    var voices: [Voice]? {
        switch self {
            case .english:
                [.englishUs0, .englishUs1, .englishIr, .englishAu, .englishGb]
            case .spanish:
                [.spanishSp, .spanishMx]
            case .chinese:
                [.chineseCn, .chineseHk, .chineseTw]
            case .french:
                [.frenchCa, .frenchFr]
            case .arabic:
                nil
            case .russian:
                [.russian]
            case .portuguese:
                [.portugueseBr, .portuguesePt]
            case .german:
                [.german]
            case .hindi:
                [.hindi]
            case .japanese:
                [.japanese]
            case .korean:
                [.korean]
            case .italian:
                [.italian]
            case .polish:
                [.polish]
            case .turkish:
                [.turkish]
            case .dutch:
                [.dutchNl, .dutchBe]
            case .czech:
                [.czech]
            case .danish:
                [.danish]
            case .greek:
                [.greek]
            case .finnish:
                [.finnish]
            case .hebrew:
                [.hebrew]
            case .hungarian:
                [.hungarian]
            case .indonesian:
                [.indonesian]
            case .norwegian:
                [.norwegian]
            case .romanian:
                [.romanian]
            case .slovak:
                [.slovak]
            case .swedish:
                [.swedish]
            case .thai:
                [.thai]
        }
    }
    
    
    var samplePhrase: String {
        switch self {
            case .english: "Hello, World!"
            case .spanish: "¡Hola, mundo!"
            case .chinese: "你好，世界!"
            case .french: "Bonjour, le monde!"
            case .arabic: "مرحبًا، أيها العالم!"
            case .russian: "Привет, мир!"
            case .portuguese: "Olá, mundo!"
            case .german: "Hallo, Welt!"
            case .hindi: "नमस्ते, दुनिया!"
            case .japanese: "こんにちは、世界!"
            case .korean: "안녕하세요, 세상!"
            case .italian: "Ciao, Mondo!"
            case .polish: "Cześć, Świecie!"
            case .turkish: "Merhaba, dünya!"
            case .dutch: "Hallo, wereld!"
            case .czech: "Ahoj, Světe!"
            case .danish: "Hej, Verden!"
            case .greek: "Γεια σου, κόσμε!"
            case .finnish: "Hei, maailma!"
            case .hebrew: "שלום, עולם!"
            case .hungarian: "Helló, Világ!"
            case .indonesian: "Halo, Dunia!"
            case .norwegian: "Hei, verden!"
            case .romanian: "Salut, lume!"
            case .slovak: "Ahoj, svet!"
            case .swedish: "Hej, världen!"
            case .thai: "สวัสดี, โลก!"
        }
    }
}

// MARK: - Hashable
extension Language: Hashable { }
