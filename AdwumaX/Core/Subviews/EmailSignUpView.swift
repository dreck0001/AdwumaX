//
//  EmailSignUpView.swift
//  Adwumax1
//
//  Created by Denis on 3/10/24.
//

import SwiftUI

struct EmailSignUpView: View {

    @StateObject private var viewModel = EmailSignUpViewModel()
    @Binding var showSignInOptions: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                AdwumaXView(text1: "Adwuma", text2: "X", size: Consts.Title.fontSize).padding()
                Text("Sign up with email.")
                    .font(.custom("Baskerville", fixedSize: CGFloat(Consts.Icon.fontSize2)))
                Spacer()
                VStack(spacing: 20) {
                    // Name field for sign-up
                    BorderedTextField(text: $viewModel.name, placeHolder: "Enter Full Name", isSecure: false)
                    // Email and password fields
                    BorderedTextField(text: $viewModel.email, placeHolder: "Enter Email", isSecure: false)
                    BorderedTextField(text: $viewModel.password, placeHolder: "Enter Password", isSecure: true)
                    
                    Button(action: {
                        // Handle sign-in or sign-up action
                        Task {
                            do {
                                try await viewModel.signUp()
                                showSignInOptions = false
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .bold()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.primaryBlueGreen))
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    EmailSignUpView(showSignInOptions: .constant(false))
}
