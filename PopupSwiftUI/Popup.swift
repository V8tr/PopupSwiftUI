//
//  Popup.swift
//  PopupSwiftUI
//
//  Created by Vadim Bulavin on 04.02.2021.
//

import SwiftUI

struct Popup<T: View>: ViewModifier {
    let popup: T
    let alignment: Alignment
    let direction: Direction
    @Binding var isPresented: Bool
    @State private var popupFrame = CGRect.zero

    init(isPresented: Binding<Bool>, alignment: Alignment, direction: Direction, @ViewBuilder content: () -> T) {
        _isPresented = isPresented
        self.alignment = alignment
        self.direction = direction
        popup = content()
    }

    func body(content: Content) -> some View {
        content
            .overlay(popupContent(), alignment: alignment)
    }

    private func popupContent() -> some View {
        Group {
            if isPresented {
                popup
                    .onGlobalFrameChange { popupFrame = $0 }
                    .transition(.offset(.init(width: 0, height: direction.offset(popupFrame: popupFrame))))
                    .animation(.spring())
            }
        }
    }
}

extension Popup {
    enum Direction {
        case top, bottom

        func offset(popupFrame: CGRect) -> CGFloat {
            switch self {
            case .top:
                let aboveScreenEdge = -popupFrame.maxY
                return aboveScreenEdge
            case .bottom:
                let belowScreenEdge = UIScreen.main.bounds.height - popupFrame.minY
                return belowScreenEdge
            }
        }
    }
}

extension View {
    func popup<T: View>(
        isPresented: Binding<Bool>,
        alignment: Alignment = .center,
        direction: Popup<T>.Direction = .bottom,
        content: () -> T
    ) -> some View {
        return modifier(Popup(isPresented: isPresented, alignment: alignment, direction: direction, content: content))
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
