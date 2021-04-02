//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Abraao Levi on 27/03/21.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷", "🍫", "🍭"]
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...emojis.count)) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
