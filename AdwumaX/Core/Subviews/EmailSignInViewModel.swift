//
//  EmailSignInViewModel.swift
//  Adwumax1
//
//  Created by Denis on 3/22/24.
//

import Foundation

@MainActor
final class EmailSignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email, password")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
