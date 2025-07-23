//
//  Color+Ext.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

extension Color {
    static let pureWhite = Color(hex: "#FFFFFF")
    static let pureBlack = Color(hex: "#000000")
    static let dustRose = Color(hex: "#a35b6e")
    static let catawba = Color(hex: "#6c3946") // pale cherry
    static let whiteCoffee = Color(hex: "e7d7d4")  // beige
    static let morningBlue = Color(hex: "#8c9da4")
    static let puce = Color(hex: "#c88ba2") // flower pink
    static let platinum = Color(hex: "#E7E7E7").opacity(0.5) // light gray
    static let smokyBlack = Color(hex: "#0F0F0F")
    static let yellowIris = Color(hex: "#EEE78E")
    static let accentOrange = Color(hex: "#FBB15B")
    static let greyish = Color(hex: "#B2B9BB")
    static let rebeccaPurple = Color(hex: "#663399") // -
    static let slateGray = Color(hex: "#708090") // -
    static let pastelTeal = Color(hex: "#63B7B7") // -
    static let spanishGray = Color(hex: "#949596")
    static let lightGray = Color(hex: "#D4D4D5")
    static let brightGray = Color(hex: "#EEEEEE") // -
    static let silverSand = Color(hex: "#C2C2C2") // -
    
    //dynamic colors
    static let dynamicGray = Color(light: .platinum, dark: .smokyBlack)
    
    struct Light {
        static let black = Color(hex: "0x212121")
        static let white = Color(hex: "0xFFFFFF")
    }

    struct Dark {
        static let black = Color(hex: "0x1F1F1F")
        static let white = Color(hex: "0xFFFFFF")
    }

    struct Green {
        static var isabelline = Color(hex: "#edf5ec") // very light green
        static var gainsboro = Color(hex: "#d7e7d4") // light green
        static var darkSeaGreen = Color(hex: "#96b4a0") // pastel green
    }
    
    struct Status {
        static var energyGreen0 = Color(hex: "#BBE3CB")
        static var energyGreen1 = Color(hex: "#A4DAB9")
        static var energyGreen2 = Color(hex: "#8ED1A8")
        static var energyGreen3 = Color(hex: "#77C896")
        static var energyGreen4 = Color(hex: "#60BF85")
        static var energyGreen5 = Color(hex: "#49B573")
    }

    struct Month {
        static var january = Color(hex: "#98A1C5")
        static var february = Color(hex: "#6c7371")
        static var march = Color(hex: "#B2D669")
        static var april = Color(hex: "#E9A4A1")
        static var may = Color(hex: "#CBD3C8")
        static var june = Color(hex: "#AF5091")
        static var july = Color(hex: "#6E8287")
        static var august = Color(hex: "#CA7D4D")
        static var september = Color(hex: "#D5A556")
        static var october = Color(hex: "#AC5E39")
        static var november = Color(hex: "#323B3E")
        static var december = Color(hex: "#671A0C")
    }
    
    struct DynamicColor {
        static let black = Color(light: Light.black, dark: Dark.white)
        static let white = Color(light: Light.white, dark: Dark.black)
    }
}

extension Color {
    var isDark: Bool {
        let uiColor = UIColor(self)
        var white: CGFloat = 0
        uiColor.getWhite(&white, alpha: nil)
        return white < 0.5
    }
    
    static var randomColor: Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
    
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            let red = Double((hexNumber & 0xff0000) >> 16) / 255.0
            let green = Double((hexNumber & 0x00ff00) >> 8) / 255.0
            let blue = Double(hexNumber & 0x0000ff) / 255.0
            self.init(red: red, green: green, blue: blue)
            return
        }

        // If unable to scan hex value, default to black
        self.init(red: 0, green: 0, blue: 0)
    }
    
    init(light: Color, dark: Color) {
        self = Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
    
    func toHex() -> String {
        if let color = UIColor(self).cgColor.components {
            let red = Int(color[0] * 255.0)
            let green = Int(color[1] * 255.0)
            let blue = Int(color[2] * 255.0)
            return String(format: "#%02x%02x%02x", red, green, blue)
        }
        return "#000000" // Return black if conversion fails
    }
}
