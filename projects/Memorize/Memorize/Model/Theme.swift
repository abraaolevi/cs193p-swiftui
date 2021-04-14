//
//  Theme.swift
//  Memorize
//
//  Created by Abraao Levi on 14/04/21.
//

import SwiftUI

struct Theme {
    var name: String
    var emojis: [String]
    var color: Color
    var numberOfPairs: Int?
    
    static let smilesTheme = Theme(name: "Smileys",
                                   emojis: ["😀", "😅", "😂", "😉", "😇", "😘", "😋", "🤑", "😐", "😬", "😔", "🥶", "🥳", "😎", "😱"],
                                   color: .yellow,
                                   numberOfPairs: 12)
    
    static let animalsTheme = Theme(name: "Animals",
                                    emojis: ["🦁", "🦊", "🐴", "🐮", "🐷", "🐭", "🐶", "🐵", "🐰", "🐼", "🐔", "🐧", "🐸", "🐳", "🐙"],
                                    color: .green,
                                    numberOfPairs: 12)
    
    static let fruitsTheme = Theme(name: "Fruits",
                                   emojis: ["🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍑", "🍒", "🍓", "🫐", "🍇", "🍈"],
                                   color: .orange,
                                   numberOfPairs: 12)
    
    static let fastFoodTheme = Theme(name: "Fast Food",
                                     emojis: ["🌭", "🌮", "🍗", "🍔", "🍟", "🍕", "🥪", "🫔", "🥨", "🥞", "🧇", "🌯", "🧆", "🍖", "🥓"],
                                     color: .red,
                                     numberOfPairs: 12)
    
    static let candiesTheme = Theme(name: "Candies",
                                    emojis: ["🍦", "🍧", "🍨", "🍩", "🍪", "🍰", "🧁", "🍫", "🍬", "🍭", "🍮", "🥧", "🍯", "🍡", "🥮"],
                                    color: .purple,
                                    numberOfPairs: 12)
    
    static let sportsTheme = Theme(name: "Sports",
                                   emojis: ["⚽", "⚾", "🏀", "🏐", "🏈", "🎾", "🥏", "🎳", "🏓", "🏸", "🏏", "🏑", "🥊", "⛳", "⛸️"],
                                   color: .blue,
                                   numberOfPairs: 12)
    
    static var themes: [Theme] = [smilesTheme, animalsTheme, fruitsTheme, fastFoodTheme, candiesTheme, sportsTheme]
}


