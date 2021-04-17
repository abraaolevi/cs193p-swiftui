//
//  MemoryGame.swift
//  Memorize
//
//  Created by Abraao Levi on 27/03/21.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>

    private(set) var score: Int = 0
    
    private var indexAlreadySeenCards: [Int: Int] = [:]
    
    private var indexOfTheOneAndTheOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    mutating func choose(card: Card) {
        if let chosenIndex = cards.index(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndTheOnlyFaceUpCard {
                
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    for (_, numberOfTimeItWasSeen) in indexAlreadySeenCards {
                        if numberOfTimeItWasSeen > 1 {
                            score -= 1
                        }
                    }
                }
                
                markAsSeen(index: chosenIndex)
                markAsSeen(index: potentialMatchIndex)

                cards[chosenIndex].isFaceUp = true
                
            } else {
                
                indexOfTheOneAndTheOnlyFaceUpCard = chosenIndex
                
            }
        }
    }
    
    private mutating func markAsSeen(index: Int) {
        if let count = indexAlreadySeenCards[index] {
            indexAlreadySeenCards[index] = count + 1
        } else {
            indexAlreadySeenCards[index] = 1
        }
        
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
