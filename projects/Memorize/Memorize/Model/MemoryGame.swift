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
            }
        }
    }

    mutating func choose(card: Card) {
        guard let chosenIndex = cards.index(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else {
            return
        }

        if let potentialMatchIndex = indexOfTheOneAndTheOnlyFaceUpCard {

            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                
                score += 2
                
            } else {
                
                if cards[chosenIndex].isAlreadySeen {
                    score -= 1
                }
                
                if cards[potentialMatchIndex].isAlreadySeen {
                    score -= 1
                }
                
            }

            cards[chosenIndex].isFaceUp = true
            
            cards[chosenIndex].isAlreadySeen = true
            cards[potentialMatchIndex].isAlreadySeen = true
            
        } else {
            
            indexOfTheOneAndTheOnlyFaceUpCard = chosenIndex
            
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
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }

        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }

        var content: CardContent
        var id: Int
        
        var isAlreadySeen: Bool = false
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        //  if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }
            return pastFaceUpTime
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up it currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left  before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentege of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}
