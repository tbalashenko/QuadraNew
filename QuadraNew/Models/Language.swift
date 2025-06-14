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
            case .english: return "en"
            case .spanish: return "es"
            case .chinese: return "zh"
            case .french: return "fr"
            case .arabic: return "ar"
            case .russian: return "ru"
            case .portuguese: return "pt"
            case .german: return "de"
            case .hindi: return "hi"
            case .japanese: return "ja"
            case .korean: return "ko"
            case .italian: return "it"
            case .polish: return "pl"
            case .turkish: return "tr"
            case .dutch: return "nl"
            case .czech: return "cs"
            case .danish: return "da"
            case .greek: return "el"
            case .finnish: return "fi"
            case .hebrew: return "he"
            case .hungarian: return "hu"
            case .indonesian: return "id"
            case .norwegian: return "no"
            case .romanian: return "ro"
            case .slovak: return "sk"
            case .swedish: return "sv"
            case .thai: return "th"
        }
    }
    
    var flagEmoji: String {
        switch self {
            case .english: return "🇺🇸"
            case .spanish: return "🇪🇸"
            case .chinese: return "🇨🇳"
            case .french: return "🇫🇷"
            case .arabic: return "🇸🇦"
            case .russian: return "🇷🇺"
            case .portuguese: return "🇵🇹"
            case .german: return "🇩🇪"
            case .hindi: return "🇮🇳"
            case .japanese: return "🇯🇵"
            case .korean: return "🇰🇷"
            case .italian: return "🇮🇹"
            case .polish: return "🇵🇱"
            case .turkish: return "🇹🇷"
            case .dutch: return "🇳🇱"
            case .czech: return "🇨🇿"
            case .danish: return "🇩🇰"
            case .greek: return "🇬🇷"
            case .finnish: return "🇫🇮"
            case .hebrew: return "🇮🇱"
            case .hungarian: return "🇭🇺"
            case .indonesian: return "🇮🇩"
            case .norwegian: return "🇳🇴"
            case .romanian: return "🇷🇴"
            case .slovak: return "🇸🇰"
            case .swedish: return "🇸🇪"
            case .thai: return "🇹🇭"
        }
    }
    
    var voices: [Voice]? {
        switch self {
            case .english:
                return [.englishUs0, .englishUs1, .englishUs2, .englishUs3, .englishGb0, .englishGb1, .englishGb2, .englishIr, .englishAu0, .englishAu1, .englishAu2]
            case .spanish:
                return [.spanishSp, .spanishMx]
            case .chinese:
                return [.chineseCn0, .chineseCn1, .chineseCn2, .chineseHk, .chineseTw]
            case .french:
                return [.frenchCa, .frenchFr0, .frenchFr1, .frenchFr2]
            case .arabic:
                return nil
            case .russian:
                return [.russian]
            case .portuguese:
                return [.portugueseBr, .portuguesePt]
            case .german:
                return [.german0, .german1, .german2]
            case .hindi:
                return [.hindi]
            case .japanese:
                return [.japanese0, .japanese1, .japanese2]
            case .korean:
                return [.korean]
            case .italian:
                return [.italian]
            case .polish:
                return [.polish]
            case .turkish:
                return [.turkish]
            case .dutch:
                return [.dutchNl, .dutchBe]
            case .czech:
                return nil
            case .danish:
                return [.danish]
            case .greek:
                return [.greek]
            case .finnish:
                return [.finnish]
            case .hebrew:
                return [.hebrew]
            case .hungarian:
                return [.hungarian]
            case .indonesian:
                return [.indonesian]
            case .norwegian:
                return [.norwegian]
            case .romanian:
                return [.romanian]
            case .slovak:
                return [.slovak]
            case .swedish:
                return [.swedish]
            case .thai:
                return [.thai]
        }
    }
    
    var samplePhrase: String {
        switch self {
            case .english: return "Hello, World!"
            case .spanish: return "¡Hola, mundo!"
            case .chinese: return "你好，世界!"
            case .french: return "Bonjour, le monde!"
            case .arabic: return "مرحبًا، أيها العالم!"
            case .russian: return "Привет, мир!"
            case .portuguese: return "Olá, mundo!"
            case .german: return "Hallo, Welt!"
            case .hindi: return "नमस्ते, दुनिया!"
            case .japanese: return "こんにちは、世界!"
            case .korean: return "안녕하세요, 세상!"
            case .italian: return "Ciao, Mondo!"
            case .polish: return "Cześć, Świecie!"
            case .turkish: return "Merhaba, dünya!"
            case .dutch: return "Hallo, wereld!"
            case .czech: return "Ahoj, Světe!"
            case .danish: return "Hej, Verden!"
            case .greek: return "Γεια σου, κόσμε!"
            case .finnish: return "Hei, maailma!"
            case .hebrew: return "שלום, עולם!"
            case .hungarian: return "Helló, Világ!"
            case .indonesian: return "Halo, Dunia!"
            case .norwegian: return "Hei, verden!"
            case .romanian: return "Salut, lume!"
            case .slovak: return "Ahoj, svet!"
            case .swedish: return "Hej, världen!"
            case .thai: return "สวัสดี, โลก!"
        }
    }
    
    init(_ rawValue: String) {
        self = Language(rawValue: rawValue) ?? .english
    }
}


