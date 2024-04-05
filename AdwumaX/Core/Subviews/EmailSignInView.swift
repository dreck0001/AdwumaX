//
//  EmailSignInView.swift
//  Adwumax1
//
//  Created by Denis on 3/15/24.
//

import SwiftUI

struct EmailSignInView: View {
    
    @StateObject private var viewModel = EmailSignInViewModel()
    @Binding var showSignInOptions: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                AdwumaXView(text1: "Adwuma", text2: "X", size: Consts.Title.fontSize).padding()
                Text("Sign in with email.")
                    .font(.custom("Baskerville", fixedSize: CGFloat(Consts.Icon.fontSize2)))
                Spacer()
                VStack(spacing: 20) {
                    // Email and password fields
                    BorderedTextField(text: $viewModel.email, placeHolder: "Enter Email", isSecure: false)
                    BorderedTextField(text: $viewModel.password, placeHolder: "Enter Password", isSecure: true)
                    
                    Button(action: {
                        // Handle sign-in or sign-up action
                        Task {
                            do {
                                try await viewModel.signIn()
                                showSignInOptions = false
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        Text("Sign In").button1()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    EmailSignInView(showSignInOptions: .constant(false))
}
