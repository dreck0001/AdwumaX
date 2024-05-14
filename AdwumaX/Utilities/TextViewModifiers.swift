//
//  TextViewModifiers.swift
//  AdwumaX
//
//  Created by Denis on 4/20/24.
//

import SwiftUI

struct TextViewModifiers: View {
    var body: some View {
        Text("This a footnote").textFootnote()
        Text("This is a title").textTitle()
    }
}

struct TextFootnote: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .italic()
            .foregroundStyle(Color.gray)
    }
}

struct TextTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Baskerville", fixedSize: CGFloat(Consts.Icon.fontSize2)))
//            .padding(.top, 20)
            .frame(height: 100)
    }
}

extension View {
    public func textFootnote() -> some View {
        modifier(TextFootnote())
    }
    public func textTitle() -> some View {
        modifier(TextTitle())
    }
}

#Preview {
    TextViewModifiers()
}
