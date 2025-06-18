//
//  Voice.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import Foundation

enum Voice: String, CaseIterable, Hashable {
    case czech, danish, greek
    case german
    case englishAu
    case englishGb
    case englishIr
    case englishUs0, englishUs1
    case spanishSp, spanishMx
    case finnish
    case frenchCa, frenchFr
    case hebrew, hindi, hungarian, indonesian
    case italian
    case japanese
    case korean
    case dutchBe, dutchNl
    case norwegian, polish
    case portugueseBr, portuguesePt
    case romanian, russian, slovak, swedish, thai, turkish
    case chineseCn, chineseHk, chineseTw
    
    var code: String {
        switch self {
            case .czech: "cs-CZ"
            case .danish: "da-DK"
            case .greek: "el-GR"
            case .german: "de-DE"
            case .englishAu: "en-AU"
            case .englishGb: "en-GB"
            case .englishIr: "en-IE"
            case .englishUs0, .englishUs1: "en-US"
            case .spanishSp: "es-ES"
            case .spanishMx: "es-MX"
            case .finnish: "fi-FI"
            case .frenchCa: "fr-CA"
            case .frenchFr: "fr-FR"
            case .hebrew: "he-IL"
            case .hindi: "hi-IN"
            case .hungarian: "hu-HU"
            case .indonesian: "id-ID"
            case .italian: "it-IT"
            case .japanese: "ja-JP"
            case .korean: "ko-KR"
            case .dutchBe: "nl-BE"
            case .dutchNl: "nl-NL"
            case .norwegian: "no-NO"
            case .polish: "pl-PL"
            case .portugueseBr: "pt-BR"
            case .portuguesePt: "pt-PT"
            case .romanian: "ro-RO"
            case .russian: "ru-RU"
            case .slovak: "sk-SK"
            case .swedish: "sv-SE"
            case .thai: "th-TH"
            case .turkish: "tr-TR"
            case .chineseCn: "zh-CN"
            case .chineseHk: "zh-HK"
            case .chineseTw: "zh-TW"
        }
    }
    
    var language: String {
        switch self {
            case .czech: "Chech"
            case .danish: "Danish"
            case .greek: "Greek"
            case .german: "German"
            case .englishAu: "English (Australia)"
            case .englishGb: "English (UK)"
            case .englishIr: "English (Ireland)"
            case .englishUs0, .englishUs1: "English (US)"
            case .spanishSp: "Spanish (Spain)"
            case .spanishMx: "Spanish (Mexico)"
            case .finnish: "Finnish"
            case .frenchCa: "French (Canada)"
            case .frenchFr: "French (France)"
            case .hebrew: "Hebrew"
            case .hindi: "Hindi"
            case .hungarian: "Hungarian"
            case .indonesian: "Indonesian"
            case .italian: "Italian"
            case .japanese: "Japanese"
            case .korean: "Korean"
            case .dutchBe: "Dutch (Belgium)"
            case .dutchNl: "Dutch (Netherlands)"
            case .norwegian: "Norwegian"
            case .polish: "Polish"
            case .portugueseBr: "Portuguese (Brazil)"
            case .portuguesePt: "Portuguese (Portugal)"
            case .romanian: "Romanian"
            case .russian: "Russian"
            case .slovak: "Slovak"
            case .swedish: "Swedish"
            case .thai: "Thai"
            case .turkish: "Turkish"
            case .chineseCn: "Chinese (China)"
            case .chineseHk: "Chinese (Hong Kong)"
            case .chineseTw: "Chinese (Taiwan)"
        }
    }
    
    var name: String {
        switch self {
            case .czech: "Zuzana"
            case .danish: "Sara"
            case .greek: "Melina"
            case .german: "Anna"
            case .englishAu: "Karen (Australia)"
            case .englishGb: "Daniel (UK)"
            case .englishIr: "Moira (Ireland)"
            case .englishUs0: "Samantha (US)"
            case .englishUs1: "Fred (US)"
            case .spanishSp: "Mónica (Spain)"
            case .spanishMx: "Paulina (Mexico)"
            case .finnish: "Satu"
            case .frenchCa: "Amélie (Canada)"
            case .frenchFr: "Thomas (France)"
            case .hebrew: "Carmit"
            case .hindi: "Lekha"
            case .hungarian: "Mariska"
            case .indonesian: "Damayanti"
            case .italian: "Alice"
            case .japanese: "Kyoko"
            case .korean: "Yuna"
            case .dutchBe: "Ellen (Belgium)"
            case .dutchNl: "Xander (Netherlands)"
            case .norwegian: "Nora"
            case .polish: "Zosia"
            case .portugueseBr: "Luciana (Brazil)"
            case .portuguesePt: "Joana (Portugal)"
            case .romanian: "Ioana"
            case .russian: "Milena"
            case .slovak: "Laura"
            case .swedish: "Alva"
            case .thai: "Kanya"
            case .turkish: "Yelda"
            case .chineseCn: "Tingting (China)"
            case .chineseHk: "Sinji (Hong Kong)"
            case .chineseTw: "Meijia (Taiwan)"
        }
    }
    
    var identifier: String {
        switch self {
            case .czech: "com.apple.voice.compact.cs-CZ.Zuzana"
            case .danish: "com.apple.voice.compact.da-DK.Sara"
            case .greek: "com.apple.voice.compact.el-GR.Melina"
            case .german: "com.apple.voice.compact.de-DE.Anna"
            case .englishAu: "com.apple.voice.compact.en-AU.Karen"
            case .englishGb: "com.apple.voice.compact.en-GB.Daniel"
            case .englishIr: "com.apple.voice.compact.en-IE.Moira"
            case .englishUs0: "com.apple.voice.compact.en-US.Samantha"
            case .englishUs1: "com.apple.speech.synthesis.voice.Fred"
            case .spanishSp: "com.apple.voice.compact.es-ES.Monica"
            case .spanishMx: "com.apple.voice.compact.es-MX.Paulina"
            case .finnish: "com.apple.voice.compact.fi-FI.Satu"
            case .frenchCa: "com.apple.voice.compact.fr-CA.Amelie"
            case .frenchFr: "com.apple.voice.compact.fr-FR.Thomas"
            case .hebrew: "com.apple.voice.compact.he-IL.Carmit"
            case .hindi: "com.apple.voice.compact.hi-IN.Lekha"
            case .hungarian: "com.apple.voice.compact.hu-HU.Mariska"
            case .indonesian: "com.apple.voice.compact.id-ID.Damayanti"
            case .italian: "com.apple.voice.compact.it-IT.Alice"
            case .japanese: "com.apple.voice.compact.ja-JP.Kyoko"
            case .korean: "com.apple.voice.compact.ko-KR.Yuna"
            case .dutchBe: "com.apple.voice.compact.nl-BE.Ellen"
            case .dutchNl: "com.apple.voice.compact.nl-NL.Xander"
            case .norwegian: "com.apple.voice.compact.nb-NO.Nora"
            case .polish: "com.apple.voice.compact.pl-PL.Zosia"
            case .portugueseBr: "com.apple.voice.compact.pt-BR.Luciana"
            case .portuguesePt: "com.apple.voice.compact.pt-PT.Joana"
            case .romanian: "com.apple.voice.compact.ro-RO.Ioana"
            case .russian: "com.apple.voice.compact.ru-RU.Milena"
            case .slovak: "com.apple.voice.compact.sk-SK.Laura"
            case .swedish: "com.apple.voice.compact.sv-SE.Alva"
            case .thai: "com.apple.voice.compact.th-TH.Kanya"
            case .turkish: "com.apple.voice.compact.tr-TR.Yelda"
            case .chineseCn: "com.apple.voice.compact.zh-CN.Tingting"
            case .chineseHk: "com.apple.voice.compact.zh-HK.Sinji"
            case .chineseTw: "com.apple.voice.compact.zh-TW.Meijia"
        }
    }
    
    var samplePhrase: String {
        switch self {
            case .czech: "Ahoj, Světe!"
            case .danish: "Hej, Verden!"
            case .greek: "Γεια σου, κόσμε!"
            case .german: "Hallo, Welt!"
            case .englishAu, .englishGb, .englishIr, .englishUs0, .englishUs1: "Hello, World!"
            case .spanishSp, .spanishMx: "¡Hola, mundo!"
            case .finnish: "Hei, maailma!"
            case .frenchCa, .frenchFr: "Bonjour, le monde!"
            case .hebrew: "שלום, עולם!"
            case .hindi: "नमस्ते, दुनिया!"
            case .hungarian: "Helló, Világ!"
            case .indonesian: "Halo, Dunia!"
            case .italian: "Ciao, Mondo!"
            case .japanese: "こんにちは、世界!"
            case .korean: "안녕하세요, 세상!"
            case .dutchBe, .dutchNl: "Hallo, wereld!"
            case .norwegian: "Hei, verden!"
            case .polish: "Cześć, Świecie!"
            case .portugueseBr, .portuguesePt: "Olá, mundo!"
            case .romanian: "Salut, lume!"
            case .russian: "Привет, мир!"
            case .slovak: "Ahoj, svet!"
            case .swedish: "Hej, världen!"
            case .thai: "สวัสดี, โลก!"
            case .turkish: "Merhaba, dünya!"
            case .chineseCn, .chineseHk, .chineseTw: "你好，世界!"
        }
    }
}
