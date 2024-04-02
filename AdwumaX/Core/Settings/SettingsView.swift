//
//  SettingsView.swift
//  Adwumax1
//
//  Created by Denis on 3/15/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInOptions: Bool
    var body: some View {
            List {
                Text("User profile management")
                Text("Virtual business card updates")
                Text("Personal analytics")
                Text("App settings")
                Text("Access to support and resources")

                if viewModel.authProviders.contains(.email) {
                    emailSection
                }
                Button("Log out") {
                    Task {
                        do {
                            try viewModel.signOut()
                            showSignInOptions = true
                        } catch {
                            print(error)
                        }
                    }
                }
                Button(role: .destructive) {
                    Task {
                        do {
                            try await viewModel.deleteAccount()
                            showSignInOptions = true
                        } catch {
                            print(error)
                        }
                    }

                } label: {
                    Text("Delete Account")
                }

            }
            .onAppear {
                viewModel.loadAuthProviders()
            }
    }
}


#Preview {
    SettingsView(showSignInOptions: .constant(false))
}

extension SettingsView {
    private var emailSection: some View {
        Section {
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        showSignInOptions = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            Text("Update your password.").bold()
            BorderedTextField(text: $viewModel.newPassword, placeHolder: "Enter New Password", isSecure: true)
            Button("Update Password") {
                Task {
                    do {
                        try await viewModel.updatePassword(newPassword: viewModel.newPassword)
                        print("PASSWORD UPDATED!")
                    } catch {
                        print(error)
                    }
                }
            }
            //            Spacer()
            Text("Update your email.").bold()
            BorderedTextField(text: $viewModel.newEmail, placeHolder: "Enter New Email", isSecure: false)
            Button("Update Email") {
                Task {
                    do {
                        try await viewModel.updateEmail(newEmail: viewModel.newEmail)
                        print("Email UPDATED!")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email Settings")
        }
    }
}
