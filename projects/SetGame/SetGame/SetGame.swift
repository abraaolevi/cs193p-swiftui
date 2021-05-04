//
//  SetGame.swift
//  SetGame
//
//  Created by Abraao Levi on 03/05/21.
//

import Foundation

struct SetGame {

    private var deck: [Card] = SetGame.buildDeck()
    
    var cards: [Card] {
        deck.filter({ $0.isVisible })
    }
    
    private var selectedCards: [Card] {
        deck.filter({ $0.isSelected })
    }

    mutating func select(card: Card) {
        if card.isSelected, selectedCards.count < 3 {
            deck[card.id].isSelected = false
        }
        
        deck[card.id].isSelected = !deck[card.id].isSelected
    }
    
    struct Card: Identifiable {
        
        enum Number: CaseIterable {
            case one, two, three
        }
        
        enum Shape: CaseIterable {
            case diamond, squiggle, oval
        }
        
        enum Shading: CaseIterable {
            case solid, striped, open
        }
        
        enum Color: CaseIterable {
            case red, green, purple
        }
        
        var id: Int
        
        let number: Number
        let shape: Shape
        let shading: Shading
        let color: Color
        
        var isVisible: Bool = false
        var isSelected: Bool = false
        var isMatched: Bool = false
    }
    
    private static func buildDeck() -> [Card] {
        var cards = [Card]()
        var id = 0
        
        for number in SetGame.Card.Number.allCases {
            for shape in SetGame.Card.Shape.allCases {
                for shading in SetGame.Card.Shading.allCases {
                    for color in SetGame.Card.Color.allCases {
                        let card = Card(id: id,
                                        number: number,
                                        shape: shape,
                                        shading: shading,
                                        color: color)
                        id += 1
                        cards.append(card)
                    }
                }
            }
        }
        
        return cards
    }
    
}
