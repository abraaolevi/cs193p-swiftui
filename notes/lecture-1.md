# Lecture 1 - Intro to Swift UI

- In many languages `struct` is a container for variables, but in Swift `struct` can contain functions and behaviors.

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello World")
    }
}
```

- In functional programming, when a `struct` inherit from another `struct` is correct to say, in this case, that `ContentView` behaves like a `View`. So is incorrect to say that `ContentView` is a `View`.
- The `some View` type says that `var body` is any type that behavies like a `View`.
- `View`s are like *legos*.
- The `var body: some View` is a computed variable, that means always it is called the code in curly braces are executed.

## Tips

- Change Dark-Mode during simulation using **Environment Overrides**
