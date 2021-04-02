//
//  MemoryGame.swift
//  Memorize
//
//  Created by Abraao Levi on 27/03/21.
//

import Foundation


struct MemoryGame<CardContent> {
    var cards: Array<Card>

    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }

    
    init(numberOfPairsOfCards: Int, contentCardFactory: (Int) -> CardContent) {
        cards = Array<Card>()

        for pairIndex in 0..<numberOfPairsOfCards {
            let content = contentCardFactory(pairIndex)

            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
