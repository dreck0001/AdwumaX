//
//  ViewModifiers.swift
//  AdwumaX
//
//  Created by Denis on 4/4/24.
//

import SwiftUI

struct ViewModifiers: View {
    var body: some View {
        Text("Hello, World!").button1()
    }
}

struct Button1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .bold()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.primaryBlueGreen))
    }
}


extension View {
    public func button1() -> some View {
        modifier(Button1())
    }
}

#Preview {
    ViewModifiers()
}
