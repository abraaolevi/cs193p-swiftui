# Assignment 2

## Task 1: Memorize as demonstrated in lectures 1 and 2

The code for this assignment is available on this commit

## Task 2: Still shuffle the cards.

Just shuffle cards as assignment 1 using `cards.shuffle()`

## Task 3 & 4: Architect the concept of a "theme" with 6 new themes

I created a new file `Model/Theme.swift` with `static var`s for the themes and an `static var themes` to group all new themes created

```swift
// Model/Theme.swift
struct Theme {
    var name: String
    var emojis: [String]
    var color: Color
    var numberOfPairs: Int?

    static let smilesTheme = Theme //....
		// ...
		static static var themes: [Theme] //...
}
```

## Task 6, 7 & 9: Update UI

I used `NavigationView` for it:

```swift
// View
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            VStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card, themeColor: viewModel.color).onTapGesture {
                        viewModel.choose(card: card)
                    }
                    .padding(5)
                }
                .foregroundColor(viewModel.color)
                
								// Task 9: Add Score Game
                Text(viewModel.score)
                    .padding()
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
						// Task 6: Show Themes name
            .navigationBarTitle(Text(viewModel.name), displayMode: .large)
            .toolbar {
								// Task 5: Add "New Game" Button
                Button("New Game") {
                    viewModel.newGame()
                }
            }
        }
        
    }
}
```

## Task 8: Keep score

- 2 points for every match.
- -1 point for every previously seen card that is involved in a mismatch.

```swift
// Model

struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
    var id: Int
    
		// New property to check if card is arelad seen before
    var isAlreadySeen: Bool = false
}

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
```

## Extra Credit 1: Support Gradient

I used the `.fill()` modifier on `Cardify.swift` to add in a `LinearGradient` based on color with opacity

```swift
struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var themeColor: Color
    
    // Assignment 2 - Extra Credit 1: Gradient Theme
    var themeColorGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [themeColor, themeColor.opacity(gradientOpacity)]), startPoint: .top, endPoint: .bottom)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill(themeColorGradient)
            }
        }
    }
    
    // MARK: - Drawing constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let gradientOpacity: Double = 0.6
}

extension View {
    func cardify(isFaceUp: Bool, themeColor: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, themeColor: themeColor))
    }
}
```

## Extra Credit 2: Score Improviment

Added a multiplier based on time that user choose the cards

```swift
// Model

struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
    var id: Int
    
    var isAlreadySeen: Bool = false

		// New property
    var faceUpTime: Date? = nil
}

private var indexOfTheOneAndTheOnlyFaceUpCard: Int? {
    get {
        cards.indices.filter({ cards[$0].isFaceUp }).only
    }
    set {
        for index in cards.indices {
            cards[index].isFaceUp = (index == newValue)

						// Added time when card is faced up
            cards[index].faceUpTime = Date()
        }
    }
}

mutating func choose(card: Card) {
    guard let chosenIndex = cards.index(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else {
        return
    }

    if let potentialMatchIndex = indexOfTheOneAndTheOnlyFaceUpCard {

				// calculate the multiplier
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

// func to calculate to multiplier
private func scoreMultiplier(for card: Card) -> Int {
    guard let faceUpTime = card.faceUpTime else {
        return 1
    }
    
    let now = Date()
    let interval = faceUpTime.timeIntervalSinceReferenceDate - now.timeIntervalSinceReferenceDate
    let multiplier = 10 - Int(interval)
    
    return max(multiplier, 1)
}
```