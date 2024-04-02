//
//  SettingsViewModel.swift
//  Adwumax1
//
//  Created by Denis on 3/22/24.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    @Published var newPassword: String = ""
    @Published var newEmail: String = ""
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws{
        try await AuthenticationManager.shared.delete()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail(newEmail: String) async throws {
        try await AuthenticationManager.shared.updateEmail(email: newEmail)
    }
    
    func updatePassword(newPassword: String) async throws {
        try await AuthenticationManager.shared.updatePassword(password: newPassword)
    }
}
