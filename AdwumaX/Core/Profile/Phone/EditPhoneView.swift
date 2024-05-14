//
//  EditPhoneView.swift
//  AdwumaX
//
//  Created by Denis on 4/20/24.
//

import SwiftUI
import Combine

struct EditPhoneView: View {
    
    private let validator = FormValidator()
    @ObservedObject var viewModel: ProfilViewwModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @State var presentSheet = false
    @State private var searchCountry: String = ""
    //    @State var disableSaveButton = true
    @State var displayErrorMessage = false

    
    @FocusState private var keyIsFocused: Bool
    
    let counrties: [CPData] = Bundle.main.decode("CountryNumbers.json")
    
    var body: some View {
        NavigationStack {
            VStack {
                if let user = viewModel.user {
                    Text("Edit Phone Number").textTitle()
                    Spacer()
                    if let phone = user.phone, phone.number != "" {
                        Text("Your current phone number: \(phone.countryCode) \(phone.number)").textFootnote().padding()
                    }
                    HStack {
                        Button {
                            presentSheet = true
                            keyIsFocused = false
                        } label: {
                            Text("\(viewModel.countryFlag) \(viewModel.countryCode)")
                                .padding(10)
                                .frame(minWidth: 80, minHeight: 53)
                                .foregroundColor(foregroundColor)
                        }
                        .overlay {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 10)
                                //                                    .stroke(Color.primary, lineWidth: 1.0)
                                    .stroke(
                                        (presentSheet || viewModel.countryCode.count > 0 || viewModel.countryFlag.count > 0) ? Color.primary : Color.gray,
                                        lineWidth: (presentSheet || viewModel.countryCode.count > 0 || viewModel.countryFlag.count > 0) ? 1.0 : 0.5
                                    )
                            }
                        }
                        BorderedTextField(text: $viewModel.number, placeHolder: "Enter New Phone Number", isSecure: false)
                            .keyboardType(.phonePad)
//                            .onReceive(Just(viewModel.number)) { _ in
//                                applyPatternOnNumbers(&viewModel.number, pattern: viewModel.countryPattern, replacementCharacter: "#")
//                            }
                            .onChange(of: viewModel.number) {
                                applyPatternOnNumbers(&viewModel.number, pattern: viewModel.countryPattern, replacementCharacter: "#")
                            }
                    }
                    if displayErrorMessage {
                        Text("Please enter a valid Phone Number")
                            .font(.caption).foregroundStyle(Color.red)
                        //                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    Button(
                        action: {
                            if viewModel.number.isValidPhoneNumber() {
                                viewModel.updatePhone()
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                displayErrorMessage = true
                            }

                        },
                        label: { Text("Save").button1() }
                    )
                    .onChange(of: viewModel.number) {
                        if $1.isValidPhoneNumber() { displayErrorMessage = false }
                    }
                    
                }
            }
            .animation(.easeInOut(duration: 0.6), value: keyIsFocused)
            .padding()
            .task { try? await viewModel.loadCUrrentUser() }

        }
        .onTapGesture { hideKeyboard() }
        .sheet(isPresented: $presentSheet) {
            NavigationView {
                List(filteredResorts) { country in
                    HStack {
                        Text(country.flag)
                        Text(country.name)
                            .font(.headline)
                        Spacer()
                        Text(country.dial_code)
                            .foregroundColor(.secondary)
                    }
                    .onTapGesture {
                        self.viewModel.countryFlag = country.flag
                        self.viewModel.countryCode = country.dial_code
                        self.viewModel.countryPattern = country.pattern
                        self.viewModel.countryLimit = country.limit
                        presentSheet = false
                        searchCountry = ""
                        applyPatternOnNumbers(&viewModel.number, pattern: viewModel.countryPattern, replacementCharacter: "#")
                    }
                }
                .listStyle(.plain)
                .searchable(text: $searchCountry, prompt: "Your country")
            }
            .presentationDetents([.medium, .large])
        }
        .presentationDetents([.medium, .large])
    }
    
    
    
    var foregroundColor: Color {
        if colorScheme == .dark {
            return Color(.white)
        } else {
            return Color(.black)
        }
    }
    var filteredResorts: [CPData] {
        if searchCountry.isEmpty {
            return counrties
        } else {
            return counrties.filter { $0.name.contains(searchCountry) }
        }
    }
    func formatPhoneNumber(_ number: String, pattern: String) -> String {
        let cleanNumber = number.filter("0123456789".contains)
        var result = ""
        var index = cleanNumber.startIndex
        
        for ch in pattern where index < cleanNumber.endIndex {
            if ch == "#" {
                result.append(cleanNumber[index])
                index = cleanNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        // Ensure we don't exceed the bounds of the input number
        if index < cleanNumber.endIndex {
            result.append(contentsOf: cleanNumber[index...])
        }
        
        return result
    }
    func applyPatternOnNumbers(_ stringvar: inout String, pattern: String, replacementCharacter: Character) {
        var pureNumber = stringvar.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else {
                stringvar = pureNumber
                return
            }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        stringvar = pureNumber
    }
}

#Preview {
    EditPhoneView(viewModel: ProfilViewwModel())
}
