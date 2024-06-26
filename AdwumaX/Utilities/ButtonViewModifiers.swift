//
//  ViewModifiers.swift
//  AdwumaX
//
//  Created by Denis on 4/4/24.
//

import SwiftUI

struct ButtonViewModifiers: View {
    var body: some View {
        Text("button1").button1()
        Text("button2").button2()
        Text("button3").button3()
        Text("button4").button4()
        Text("buttonDisable1").button1().buttonDisable()
        Text("buttonDisable2").button2().buttonDisable()
        Text("buttonDisable3").button3().buttonDisable()
        Text("buttonDisable4").button4().buttonDisable()

    }
}

var radius: CGFloat = 30
var maxHeight: CGFloat = 10

struct Button1: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .frame(maxWidth: .infinity, maxHeight: maxHeight)
            .padding()
            .bold()
            .background(RoundedRectangle(cornerRadius: radius).fill(colorScheme == .dark ? .white : .black))
    }
}
struct Button2: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(maxWidth: .infinity, maxHeight: maxHeight)
            .padding()
            .bold()
            .background(RoundedRectangle(cornerRadius: radius)
                .fill(colorScheme == .dark ? .black : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(colorScheme == .dark ? .white : .black, lineWidth: 2)
                )
            )
    }
    
}
struct Button3: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .frame(maxWidth: .infinity, maxHeight: maxHeight)
            .padding()
            .bold()
            .background(RoundedRectangle(cornerRadius: radius)
                .fill(Color.primary1))
    }
}

struct Button4: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.primary1)
            .frame(maxWidth: .infinity, maxHeight: maxHeight)
            .padding()
            .bold()
            .background(RoundedRectangle(cornerRadius: radius)
                .fill(colorScheme == .dark ? .black : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.primary1, lineWidth: 2)
                )
            )
    }
}
    
struct ButtonDisable: ViewModifier {
    let status: Bool
    func body(content: Content) -> some View {
        if status {
            content
                .disabled(true)
                .opacity(0.4)
        } else {
            content
                .disabled(false)
                .opacity(1)
        }
        
    }
}
struct ButtonEnable: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disabled(false)
            .opacity(1)
    }
}


extension View {
    public func button1() -> some View {
        modifier(Button1())
    }
    public func button2() -> some View {
        modifier(Button2())
    }
    public func button3() -> some View {
        modifier(Button3())
    }
    public func button4() -> some View {
        modifier(Button4())
    }
    public func buttonDisable(status: Bool = true) -> some View {
        self.modifier(status ? ButtonDisable(status: true) : ButtonDisable(status: false))

    }
    public func buttonEnable() -> some View {
        modifier(ButtonEnable())
    }
}

#Preview {
    ButtonViewModifiers()
}
