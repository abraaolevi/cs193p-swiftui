# Assignment 1

## Task 1: Memorize as demonstrated in lectures 1 and 2

The code for this assignment is available on this commit

## Task 2: Shuffle the cards

To shuffle an array can be done simply with `.shuffle()` method.

I understand that shuffle is a model's responsibility

```swift
// Model MemoryGame
init(numberOfPairsOfCards: Int, contentCardFactory: (Int) -> CardContent) {
	cards = Array<Card>()
	
	for pairIndex in 0..<numberOfPairsOfCards {
	    let content = contentCardFactory(pairIndex)
	
	    cards.append(Card(content: content, id: pairIndex*2))
	    cards.append(Card(content: content, id: pairIndex*2+1))
	}
	
	cards.shuffle()
}
```

## Task 3: Force each card to have a width to height ratio 2:3

Applied to the `HStack` of the View using `aspectRatio()` modifier:

```swift
// View
HStack {
	ForEach(viewModel.cards) { card in
	// ...          
}
.aspectRatio(2/3, contentMode: .fit)
```

## Task 4: Randomize number of pairs of cards

It con be done using `Int.random()` 

```swift
// ViewModel
return MemoryGame<String>(numberOfPairs: Int.random(in: 2...5)) { index in
// ...
```

## Task 5: Adjust size of the Font

```swift
// View
HStack {
	// ...          
}
.font(viewModel.cards.count < 5 ? Font.largeTitle : Font.title)
```

## Extra Credit: More emojis

Just add more emojis at `ViewModel` function generator