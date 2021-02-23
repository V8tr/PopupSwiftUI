## Article related to this project

- [Custom Popup in SwiftUI](https://www.vadimbulavin.com/swiftui-popup-sheet-popover/).

---

# PopupSwiftUI

The project demonstrates how to implement a custom popup in SwiftUI.

Usage:

```swift
struct Popup_Previews: PreviewProvider {
    static var previews: some View {
        Color.clear
            .modifier(Popup(isPresented: true, // <--- Add the popup view modifier
                            content: { Color.yellow.frame(width: 100, height: 100) }))
            .previewDevice("iPod touch")
    }
}
```

Result:

| Loading Indicator | Snackbar Message |
|---|---|
| <img src="https://github.com/V8tr/PopupSwiftUI/raw/main/demo-2.gif" alt="How to show a popup in SwiftUI"/> | <img src="https://github.com/V8tr/PopupSwiftUI/raw/main/demo-3.gif" alt="How to show a popup in SwiftUI"/> |
