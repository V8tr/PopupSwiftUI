## Article related to this project

- [Custom Popup in SwiftUI](https://www.vadimbulavin.com/swiftui-popup-sheet-popover/).

---

# PopupSwiftUI

The project demonstrates how to implement a custom popup in SwiftUI.

Usage:

```swift
struct Popup3_Previews: PreviewProvider {

    static var previews: some View {
        Preview()
            .previewDevice("iPod touch")
    }

    // Helper view that shows a popup
    struct Preview: View {
        @State var isPresented = false

        var body: some View {
            ZStack {
                Color.clear
                VStack {
                    Button("Toggle", action: { isPresented.toggle() })
                    Spacer()
                }
            }
            .modifier(Popup(isPresented: isPresented, // <--- Add the popup view modifier
                            alignment: .center,
                            content: { Color.yellow.frame(width: 100, height: 100) }))
        }
    }
}
```

Result:

<p align="center">
  <img src="https://github.com/V8tr/PopupSwiftUI/raw/main/demo-1.gif" alt="How to show a popup in SwiftUI"/>
</p>
