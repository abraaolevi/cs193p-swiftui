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
        
        if selectedCards.count == 3 {
    
            var countNumber = 0
            var countShape = 0
            var countShadding = 0
            var countColor = 0

            for cardA in selectedCards {
                for cardB in selectedCards {
                    if cardA.id == cardB.id {
                        continue
                    }
                    
                    if cardA.number == cardB.number {
                        countNumber += 1
                    }
                    
                    if cardA.shape == cardB.shape {
                        countShape += 1
                    }
                    
                    if cardA.shading == cardB.shading {
                        countShadding += 1
                    }
                    
                    if cardA.color == cardB.color {
                        countColor += 1
                    }
                }
            }
            
            let isSet = isSet([
                .number: getState(of: countNumber),
                .shape: getState(of: countShape),
                .shadding: getState(of: countShadding),
                .color: getState(of: countColor)
            ])
            
            
            if isSet {
                for selectedCard in selectedCards {
                    deck[selectedCard.id].isMatched = true
                }
            }
        }
    }
    
    private func isSet(_ result: [Feature: State]) -> Bool {
        
        var countSameFeatures = 0
        var countDifferentFeatures = 0
        
        for feature in Feature.allCases {
            if result[feature] == .allSame {
                countSameFeatures += 1
            }
            
            if result[feature] == .allDifferent {
                countDifferentFeatures += 1
            }
        }
        
        return countSameFeatures == 3 || countDifferentFeatures == 4
    }
    
    private func getState(of numberOccurrencies: Int) -> State {
        if numberOccurrencies == 0 {
            return .allDifferent
        }
        if numberOccurrencies == 6 {
            return .allSame
        }
        return .someDifferent
    }
    
    enum Feature: CaseIterable {
        case number, shape, shadding, color
    }
    
    enum State {
        case allDifferent, someDifferent, allSame
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
