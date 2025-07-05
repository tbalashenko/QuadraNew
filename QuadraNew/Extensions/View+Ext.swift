//
//  View+Ext.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 18/05/2025.
//

import SwiftUI

extension View {
    func northWestShadow(
        radius: CGFloat = 4,
        offset: CGFloat = 3
    ) -> some View {
        return self
            .shadow(
                color: .highlight, radius: radius, x: -offset, y: -offset)
            .shadow(
                color: .shadow, radius: radius, x: offset, y: offset)
    }

    func southEastShadow(
        radius: CGFloat = 4,
        offset: CGFloat = 3
    ) -> some View {
        return self
            .shadow(color: .shadow, radius: radius, x: -offset, y: -offset)
            .shadow(color: .highlight, radius: radius, x: offset, y: offset)
    }
}

extension View {
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        self.frame(width: size.width, height: size.height, alignment: alignment)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    
    func center() -> some View {
        self.modifier(CenterModifier())
    }
    
    func customListRow() -> some View {
        self.modifier(CustomListRowModifier())
    }
    
    func customListStyle() -> some View {
        self.modifier(CustomListModifier())
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}

struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
        .background(Color.element)
    }
}

struct CustomListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(Color.element)
    }
}

struct CustomListModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .contentMargins(.leading, 0, for: .scrollIndicators)
            .background(Color.element)
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
    }
}

extension View {
    public func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        view: @escaping () -> PopupContent
    ) -> some View {
        self.modifier(
            Popup(
                isPresented: isPresented,
                view: view)
        )
    }
}
