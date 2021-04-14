//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abraao Levi on 27/03/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    private var theme: Theme
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()

        /// Random number of pairs
        let numberOfPairs = theme.numberOfPairs ?? Int.random(in: 0..<emojis.count)
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    init() {
        let theme = Theme.themes.randomElement()!
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
    
    var score: String {
        "Score: \(model.points)"
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        self.theme = Theme.themes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
