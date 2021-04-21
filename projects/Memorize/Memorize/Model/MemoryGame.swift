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
    
    private var indexOfTheOneAndTheOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter({ cards[$0].isFaceUp }).only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
                cards[index].faceUpTime = Date()
            }
        }
    }

    mutating func choose(card: Card) {
        guard let chosenIndex = cards.index(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else {
            return
        }

        if let potentialMatchIndex = indexOfTheOneAndTheOnlyFaceUpCard {

            let multiplier = scoreMultiplier(for: cards[potentialMatchIndex])
            
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                
                score += 2 * multiplier
                
            } else {
                
                if cards[chosenIndex].isAlreadySeen {
                    score -= 1 * multiplier
                }
                
                if cards[potentialMatchIndex].isAlreadySeen {
                    score -= 1 * multiplier
                }
                
            }

            cards[chosenIndex].isFaceUp = true
            
            cards[chosenIndex].isAlreadySeen = true
            cards[potentialMatchIndex].isAlreadySeen = true
            
        } else {
            
            indexOfTheOneAndTheOnlyFaceUpCard = chosenIndex
            
        }
    
    }
    
    private func scoreMultiplier(for card: Card) -> Int {
        guard let faceUpTime = card.faceUpTime else {
            return 1
        }
        
        let now = Date()
        let interval = faceUpTime.timeIntervalSinceReferenceDate - now.timeIntervalSinceReferenceDate
        let multiplier = 10 - Int(interval)
        
        return max(multiplier, 1)
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
        
        var isAlreadySeen: Bool = false
        var faceUpTime: Date? = nil
    }
}
