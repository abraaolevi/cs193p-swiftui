# Lecture 2 - MVVM + Swift Type

We can write code in two different approaches: the **Declarative** way (SwiftUI) and the **Imperative** way (UIKit)

## Swift Types

- `struct`
- `class`
- `protocol`
- `Generics`
- `enum`
- `function`

### `struct` vs `class`

**Similarities**

- They can have properties with `let` and `var`
- They can have stored and computed `var`s
- They can have behaviors with `funcs`
- They can have custom `init`s

**Differences**

| `struct`                             | `class`                         |
|--------------------------------------|---------------------------------|
| Value type                           | Reference type                  |
| Copied when passed or assigned       | Passed around via pointers      |
| Copy on write                        | Automatically reference counted |
| Function programming                 | Object-oriented programming     |
| No inheritance                       | Inheritance (single)            |
| "Free" init initializes ALL vars     | "Free" init initializes NO vars |
| Mutability must be explicitly stated | Always mutable                  |
| Your "go to" data structure          | Used in specific circumstances  |

### Generics (Type parameter)

- Sometimes we just "*don't care*" type. Eg. data inside Arrays

```swift
struct Array<Element> {
	// …
	func append(_ element: Element) { . . . }
}

var a = Array<Int>()
a.append(5)
```

- Can have multiple don't care type parameters Eg. <Element, Foo>

 ### Functions

- Functions can be a type as well

```swift
// foo’s type: function that takes a Double and returns Double
var foo: (Double) -> Double
```

## MVVM (Model-View-ViewModel)

Is a code organization, a design paradigm

### Model

- It is common to be a `struct`
- UI Independent
- Data + Logic
- The Truth

### View

- Reflects the Model
    - Stateless
    - Declared
    - Reactive
- What you see (observes publications)
    - `@ObservedObject`
    - `@Binding`
    - `@EnvironementObject`
    - `.onreceive`

### ViewModel

- It is a `class` because its allow multiple *Views* to share / point to it
- Notices changes in Model & **Publishes changes** to View
    - Binds View to Model
    - Interpreter
    - `ObservableObject`
    - `@Published`
    - `.environementObject()`
    - `objectWillChange.send()`
- Processes **Intent** from View using functions within & Modifies the Model

### MVVM Data Flow

**Model** → notices changes → **ViewModel** → publishes "something changed" → **View**

**View** → calls Intent function → **ViewModel** → modifies the Model → **Model**

## Demo

```swift
class EmojiMemoryGame {
    private(set) var model: MemoryGame<String>
}
```

- `private(set)` means that `model` property is read-only for who are using the class and only the `EmojiMemoryGame` can change it. It is a middle between `public` and `private`.
- `ForEach` items needs to be conform `Identifiable` protocol
- **Intents** are `func`s that allow *Views* to access *Model*
- `static func`
    - Removes the need to initialize class variables to use the function
    - Static functions **belong to the type** (class/struct) and not the instance - Universal for all instances

    ```swift
    class EmojiMemoryGame {
      	// Need to use class name to call function
      	private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        static func createMemoryGame() -> MemoryGame<String> {
    			// ...
        }
    }
    ```

- `class func`
    - Like static functions but can be overwritten by subclasses

    ```swift
    class ClassA {
      class func func1() -> String {
        return "func1"
      }

      static func func2() -> String {
        return "func2"
      }

      /* same as above
      final class func func2() -> String {
        return "func2"
      }
      */
    }

    class ClassB : ClassA {
      override class func func1() -> String {
        return "func1 in ClassB"
      }

      // ERROR: Class method overrides a 'final` class method
      override static func func2() -> String {
        return "func2 in ClassB"
      }
    }
    ```

- Closures

    ```swift
    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairs: 2, cardContentFactory: { (pairIndex: Int) -> String in
    		return "😋"
    })

    // Ca be write as:

    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairs: 2) { _ in "😋" }
    ```
