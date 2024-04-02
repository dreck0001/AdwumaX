//
//  EmailSignUpViewModel.swift
//  Adwumax1
//
//  Created by Denis on 3/22/24.
//

import Foundation

@MainActor
final class EmailSignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty, !name.isEmpty else {
            print("No email, password, or name")
            return
        }
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
}
