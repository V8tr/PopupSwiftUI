//
//  PopupStepByStep.swift
//  PopupSwiftUI
//
//  Created by Vadim Bulavin on 09.02.2021.
//

import SwiftUI

struct Popup1<T: View>: ViewModifier {
    let popup: T
    let isPresented: Bool

    init(isPresented: Bool, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        popup = content()
    }

    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct Popup1_Previews: PreviewProvider {
    static var previews: some View {
        Color.clear
            .modifier(Popup1(isPresented: true,
                             content: { Color.yellow.frame(width: 100, height: 100) }))
            .previewDevice("iPod touch")
    }
}

struct Popup2<T: View>: ViewModifier {
    let popup: T
    let alignment: Alignment
    let isPresented: Bool

    init(isPresented: Bool, alignment: Alignment, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        self.alignment = alignment
        popup = content()
    }

    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .animation(.spring())
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
            }
        }
    }
}

struct Popup2_Previews: PreviewProvider {
    static var previews: some View {
        Color.clear
            .modifier(Popup2(isPresented: true,
                             alignment: .bottomTrailing,
                             content: { Color.yellow.frame(width: 100, height: 100) }))
            .modifier(Popup2(isPresented: true,
                             alignment: .topTrailing,
                             content: { Color.orange.frame(width: 100, height: 100) }))
            .modifier(Popup2(isPresented: true,
                             alignment: .center,
                             content: { Color.red.frame(width: 100, height: 100) }))
            .modifier(Popup2(isPresented: true,
                             alignment: .topLeading,
                             content: { Color.green.frame(width: 100, height: 100) }))
            .modifier(Popup2(isPresented: true,
                             alignment: .bottomLeading,
                             content: { Color.blue.frame(width: 100, height: 100) }))
            .previewDevice("iPod touch")
    }
}

struct Popup3<T: View>: ViewModifier {
    let popup: T
    let alignment: Alignment
    let isPresented: Bool

    init(isPresented: Bool, alignment: Alignment, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        self.alignment = alignment
        popup = content()
    }

    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .animation(.spring())
                    .transition(.offset(x: 0, y: geometry.belowScreenEdge))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
            }
        }
    }
}

private extension GeometryProxy {
    var belowScreenEdge: CGFloat {
        UIScreen.main.bounds.height - frame(in: .global).minY
    }
}

private extension View {
    func onGlobalFrameChange(_ onChange: @escaping (CGRect) -> Void) -> some View {
        background(GeometryReader { geometry in
            Color.clear.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
        })
        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }

    func print(_ varargs: Any...) -> Self {
        Swift.print(varargs)
        return self
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static let defaultValue = CGRect.zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct Popup3_Previews: PreviewProvider {

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
            .modifier(Popup3(isPresented: isPresented,
                             alignment: .center,
                             content: { Color.yellow.frame(width: 100, height: 100) }))
        }
    }

    static var previews: some View {
        Preview()
            .previewDevice("iPod touch")
    }
}

struct Popup4_Previews: PreviewProvider {

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
            .modifier(Popup3(isPresented: isPresented,
                             alignment: .center,
                             content: { Color.yellow.frame(width: 100, height: 100) }))
        }
    }

    static var previews: some View {
        Preview()
            .previewDevice("iPod touch")
    }
}
