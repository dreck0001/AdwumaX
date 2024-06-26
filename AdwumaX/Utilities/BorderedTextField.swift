//
//  BorderedTextField.swift
//  Adwumax1
//
//  Created by Denis on 3/11/24.
//

import SwiftUI

struct BorderedTextField: View {
    @Binding var text: String
    private let placeHolder: String
    private let font: Font
    private let isSecure: Bool
    
    @State private var showPressed = false
    
    @FocusState private var isFocused: Bool
    
    init(text: Binding<String>, placeHolder: String = "", font: Font = .body, isSecure: Bool = false) {
        _text = text
        self.placeHolder = placeHolder
        self.font = font
        self.isSecure = isSecure
    }
    
    var body: some View {
        textFieldView
            .animation(.smooth, value: isFocused)
    }
    
    private var textFieldView: some View {
        ZStack {
            VStack(alignment: .leading) {
                if isSecure, showPressed == false {
                    SecureField(placeHolder, text: $text)
                } else {
                    TextField(placeHolder, text: $text)
                }
            }
            .font(font)
            .focused($isFocused)
            .padding()
            .padding(.trailing, isSecure ? 30 : 0)
            .overlay(content: {
                oulineView
            })
            showHideButtonView
        }
    }
    
    private var oulineView: some View {
        ZStack(alignment: .leading, content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke((isFocused || text.count > 0) ? Color.primary : Color.gray,
                        lineWidth: (isFocused || text.count > 0) ? 1.0 : 0.5)
            tagView
        })
    }
    
    private var tagView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(placeHolder.replacingOccurrences(of: "Enter ", with: ""))
                    .font(.footnote)
                    .fontWeight(.medium)
                    .padding(.horizontal, 3.0)
                    .foregroundColor(.primary.opacity(0.5))
                    .background(Color(uiColor: .systemBackground))
                    .offset(y: text.count > 0 ? -8.0 : 0.0)
                    .opacity(text.count > 0 ? 1.0 : 0.0)
                    .animation(.bouncy, value: text.count > 0)
            }
            .padding(.horizontal, 10.0)
            Spacer()
        }
    }
    
    private var showHideButtonView: some View {
        return ZStack {
            if isSecure {
                HStack {
                    Spacer()
                    Button {
                        showPressed.toggle()
                    } label: {
                        Text(showPressed ? "Hide" : "Show")
                            .font(.footnote)
                            .padding(4.0)
                            .background(Color.secondary)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                            
                    }
                }
                .padding(.trailing, 8.0)
            }
        }
    }
}

#Preview {
    VStack(spacing: 25) {
        BorderedTextField(text: .constant("test"), placeHolder: "Enter Name", isSecure: false)
        BorderedTextField(text: .constant("test"), placeHolder: "Enter Password", isSecure: true)
    }
    .padding()
}
