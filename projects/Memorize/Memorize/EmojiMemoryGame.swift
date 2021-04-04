//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abraao Levi on 27/03/21.
//

import SwiftUI


struct EmojiMemoryGameTheme {
    var name: String
    var emojis: [String]
    var showsTheNumberOfCardsRandomly: Bool
    var color: Color
    
    var numberOfPairsOfCards: Int {
        showsTheNumberOfCardsRandomly ? emojis.count : Int.random(in: 2...emojis.count)
    }
}

class EmojiMemoryGame: ObservableObject {
    @Published private var theme: EmojiMemoryGameTheme
    @Published private var model: MemoryGame<String>

    static func themeForMemoryGame() -> EmojiMemoryGameTheme {
        let smilesTheme = EmojiMemoryGameTheme(name: "Smileys", emojis: ["😀", "😅", "😂", "😉", "😇", "😘", "😋", "🤑", "😐", "😬", "😔", "🥶", "🥳", "😎", "😱"],
                                               showsTheNumberOfCardsRandomly: false, color: .yellow)
        let animalsTheme = EmojiMemoryGameTheme(name: "Animals", emojis: ["🦁", "🦊", "🐴", "🐮", "🐷", "🐭", "🐶", "🐵", "🐰", "🐼", "🐔", "🐧", "🐸", "🐳", "🐙"],
                                                showsTheNumberOfCardsRandomly: false, color: .green)
        let fruitsTheme = EmojiMemoryGameTheme(name: "Fruits", emojis: ["🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍑", "🍒", "🍓", "🫐", "🍇", "🍈"],
                                               showsTheNumberOfCardsRandomly: true, color: .orange)
        let fastFoodTheme = EmojiMemoryGameTheme(name: "Fast Food", emojis: ["🌭", "🌮", "🍗", "🍔", "🍟", "🍕"],
                                                 showsTheNumberOfCardsRandomly: true, color: .red)
        let candiesTheme = EmojiMemoryGameTheme(name: "Candies", emojis: ["🍦", "🍧", "🍨", "🍩", "🍪", "🍰", "🧁", "🍫", "🍬", "🍭", "🍮"],
                                                showsTheNumberOfCardsRandomly: true, color: .orange)
        let sportsTheme = EmojiMemoryGameTheme(name: "Sports", emojis: ["⚽", "⚾", "🏀", "🏐", "🏈", "🎾"],
                                               showsTheNumberOfCardsRandomly: false, color: .blue)
        
        let themes = [smilesTheme, animalsTheme, fruitsTheme, fastFoodTheme, candiesTheme, sportsTheme]
        
        return themes[Int.random(in: 0..<themes.count)]
    }
    
    static func createMemoryGame(with theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    init() {
        let theme = EmojiMemoryGame.themeForMemoryGame()
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    // MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var color: Color {
        theme.color
    }
    
    var name: String {
        theme.name
    }
    
    var points: String {
        "\(model.points) Points"
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        self.theme = EmojiMemoryGame.themeForMemoryGame()
        self.model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
