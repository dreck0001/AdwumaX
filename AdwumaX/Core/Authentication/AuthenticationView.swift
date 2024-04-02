//
//  AuthenticationView.swift
//  Adwumax1
//
//  Created by Denis on 3/18/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    @Environment(\.colorScheme) var colorScheme
    @State private var isSignIn = true // Toggle between Sign In and Sign Up
    private var signInSignUpText: String {
        isSignIn ? "Sign in with " : "Sign up with "
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                AdwumaXView(text1: "Adwuma", text2: "X", size: Consts.Title.fontSize).padding()
                MotoView().padding()
                Text("Your Need, Our Deed: Connecting Skills with Demands.")
                    .multilineTextAlignment(.center) // Center the text
                    .padding(.horizontal) // Ensure it has space on the sides if needed
                    .padding(.bottom)
                VStack(spacing: 20) {
                    if isSignIn {
                        NavigationLink(destination: EmailSignInView(showSignInOptions: $showSignInView)) {
                            ClearButton(imageName: "envelope", buttonText: "\(signInSignUpText)Email", isSysName: true)
                        }
                    }
                    else {
                        NavigationLink(destination: EmailSignUpView(showSignInOptions: $showSignInView)) {
                            ClearButton(imageName: "envelope", buttonText: "\(signInSignUpText)Email", isSysName: true)
                        }
                    }
                    Button(action: {
                        Task {
                            do {
                                try await viewModel.signInGoogle()
                                showSignInView = false
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        ClearButton(imageName: "googleIcon", buttonText: "\(signInSignUpText)Google")
                    }
                    
                    Button(action: {
                        Task {
                            do {
                                try await viewModel.signInApple()
                                showSignInView = false
                            } catch {
                                print(error)
                            }
                        }
                    }) {
                        ClearButton(imageName: "apple.logo", buttonText: "\(signInSignUpText)Apple", isSysName: true)
                    }
                    
                    
//                    if isSignIn {
//                        NavigationLink(destination: xSignInView()) {
//                            ClearButton(imageName: colorScheme == .dark ? "x_dark" : "x_light", buttonText: "Sign in with X")
//                        }
//                        .transition(.opacity) // Specify the transition effect
//                    }
//                    NavigationLink(destination: AppleSignUpView()) {
//                        ClearButton(imageName: "facebook", buttonText: "\(signInSignUpText)Facebook")
//                    }
                    
                    
                    
                    
//                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
//                        Task {
//                            do {
//                                try await viewModel.signInGoogle()
//                                showSignInView = false
//                            } catch {
//                                print(error)
//                            }
//                        }
//                    }
//                    Button(action: {
//                        Task {
//                            do {
//                                try await viewModel.signInApple()
//                                showSignInView = false
//                            } catch {
//                                print(error)
//                            }
//                        }
//                    }, label: {
//                        SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
//                            .allowsHitTesting(false)
//                    })
//                    .frame(height: 40)
                    
                    Spacer()
                    
                    SignInSignUpToggleView(isSignIn: $isSignIn)
                    
                    if isSignIn {
                        ForgotHelpView()
                            .padding(.top, 10) // Adjust padding as needed
                    }
                    
                    AgreementTextView(isSignIn: isSignIn)
                        .padding(.horizontal)
                        .padding(.top, 50)
                }
                .padding()
            }
        }
    }
}

struct SignInSignUpToggleView: View {
    @Binding var isSignIn: Bool
    var body: some View {
        HStack {
            Text(isSignIn ? "Don’t have an account?" : "Already have an account?")
            Button(action: {
                withAnimation {
                    isSignIn.toggle()
                }
            }) {
                Text(isSignIn ? "Sign up." : "Sign in.")
                    .foregroundColor(Color.primaryBlueGreen)
            }
        }
        .scaleEffect(0.9)
    }
}

struct ForgotHelpView: View {
    @State private var showHelpView = false
    
    var body: some View {
        HStack(spacing: 0) {
            Text("Forgot email or trouble signing in? ")
            Button("Get help.") {
                showHelpView = true
            }
            .foregroundStyle(Color.primaryBlueGreen) // Style as needed
            .sheet(isPresented: $showHelpView) {
                GetHelpView() // Present the HelpView modally
            }
        }
        // Apply any additional styling as needed
        .scaleEffect(0.85)
    }
}

struct GetHelpView: View {
    var body: some View {
        // Your help content here
        Text("Help content goes here.")
            .padding()
    }
}

struct AgreementTextView: View {
    var isSignIn: Bool
    var body: some View {
        HStack {
            Text("By \(isSignIn ? "signing in," : "signing up,") you agree to our ")
            + Text("Terms of Service").underline() // Add action for TOS
            + Text(" and acknowledge that our ")
            + Text("Privacy Policy").underline() // Add action for Privacy Policy
            + Text(" applies to you.")
        }
        .multilineTextAlignment(.leading)
        .font(.footnote)
    }
}

#Preview {
    AuthenticationView(showSignInView: .constant(false))
}
