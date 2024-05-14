//
//  EditPhoneView2.swift
//  AdwumaX
//
//  Created by Denis on 5/1/24.
//

import SwiftUI

struct EP: View {
    
    @State var presentSheet = false
    @FocusState private var keyIsFocused: Bool
    
    @State var countryCode : String = "+1"
    @State var countryFlag : String = "🇺🇸"
    
    @State var disableSaveButton = true

    @ObservedObject var viewModel: ProfilViewwModel
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    let phone = "5086156145"
    var body: some View {
        NavigationStack {
            VStack {
                Text("Edit Phone Number").textTitle()
                Spacer()
                Text("Your current phone number: \(phone)").textFootnote().padding()
                HStack {
                    Button{
                        presentSheet = true
                        keyIsFocused = false
                    } label: {
                        Text("\(countryFlag) \(countryCode)")
                            .padding(10)
                            .frame(minWidth: 80, minHeight: 53)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                (presentSheet || countryCode.count > 0 || countryFlag.count > 0) ? Color.primary : Color.gray,
                                lineWidth: (presentSheet || countryCode.count > 0 || countryFlag.count > 0) ? 1.0 : 0.5
                            )
                    }
                    BorderedTextField(text: $viewModel.number, placeHolder: "Enter New Phone Number", isSecure: false)
                        .keyboardType(.phonePad)
                }
                Text("Please enter a valid Phone Number")
                    .font(.caption).foregroundStyle(Color.red)
                
                Spacer()
                
                Button(
                    action: {
                        viewModel.updatePhone()
                        presentationMode.wrappedValue.dismiss()
                    },
                    label: { Text("Save").button1() }
                )
                .buttonDisable(status: disableSaveButton)
                .onChange(of: viewModel.number) {
                    if disableSaveButton {
                        
                    }
                    disableSaveButton = !viewModel.number.isValidPhoneNumber()
                }
            }.padding()

        }
    }
}

#Preview {
    EP(viewModel: ProfilViewwModel())
}
