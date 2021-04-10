# Lecture 3 - Reactive UI Protocols Layout

## Demo

- All **arguments** in functions are constants
- For Value Types
    - In a `struct` always a method changes itself, the method need `mutating` keyword: `mutating func ...`
    - All `init`s are `mutating`
- A `ObservableObject` always need to be a *class* (viewModel)
    - Properties to be observed in a *class* need to have the wrapper `@Published` in front of declaration: `@Published private var model: ....`
    - For `ObservableObject` classes, `@Published` **publishes changes** in *Model* to the *View*

        ```swift
        // View Model
        class EmojiMemoryGame: ObservableObject {
        	// Changes to model should trigger view to reload
          @Published private var model: MemoryGame<String>
        	// ...
        ```

- To bind to the view, the viewModel (or object to be observed) need to have the wrapper `@ObservedObject`: `@ObservedObject var viewModel: ...`
    - `@ObservedObject` to **receive** `@Published` changes

        ```swift
        // View
        struct EmojiMemoryGameView: View {
        	@ObservedObject var viewModel: EmojiMemoryGame
        	// ...
        ```

- So every time the the thing that are observed changes, the *ViewModel* send an "*event*" for a *View* to reflect the current state of object that is observed.
- Implicitly the wrapper `@Published` calls the `objectWillChange.send()` from `ObservableObject`. You can call manually `objectWillChange.send()` before any change perform if you like, but is much more convenient to use the `@Published` wrapper.

## Protocols

- Protocol is a "stripped down" struct/class with **no storage**
- Structs / classes can **inherit multiple protocols**
    - Every protocol's `var` and `func` **must** be implemented
- Protocol is a type

```swift
protocol Moveable {
	func move(by: Int) 
	var hasMoved: Bool { get }
	var distanceFromStart: Int { get set }}
}

struct PortableThing: Moveable {
	// must implement move(by:), hasMoved and distanceFromStart
}
```

### Protocol Extensions

- Can add implementations to a protocol using an extension to the protocol
- Can also add extensions to Classes / Structs

```swift
extension Moveable { 
	func registerWithDMV() { /* implementation here */ }
}
```

### Generics and Protocols

```swift
protocol Greatness {
	func isGreaterThan(other: Self) -> Bool
	// Self is the type of thing implementing the protocol
}

extension Array where Element: Greatness {
	// ...  
}
```

## Layouts

### **Space Appointment**

- *Container Views* offer space to the *Views* inside
- *Views* choose their size
- *Container Views* then position the *Views* inside of them
- Choice of who offer spaces can be overwritten with `.layoutPriority(Any Number > 0)`
- For custom sizes, we can use the View `GeometryReader`
    - `GeometryReader` knows how much space is offered to it
- `.edgesIgnoringSafeArea()` allows drawing in safe areas to increase size of *View* up to the edges
