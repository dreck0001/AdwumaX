//
//  ProfileView.swift
//  Adwumax1
//
//  Created by Denis on 3/19/24.
//

import SwiftUI

@MainActor
final class ProfilViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    func loadCUrrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func togglePremiumStatus() {
        guard let user else { return }
        let currentValue = user.isPremium ?? false
        Task {
            try await UserManager.shared.updateUserPremiumStatus(userId: user.userId, isPremium: !currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func addUserPreference(text: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.addUserPreference(userId:user.userId, preference: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func removeUserPreference(text: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.removeUserPreference(userId:user.userId, preference: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func addFavouriteMovie() {
        guard let user else { return }
        let movie = Movie(id: "1", title: "Avatar 2", isPopular: true)
        Task {
            try await UserManager.shared.addFavoriteMovie(userId: user.userId, movie: movie)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    func removeFavouriteMovie() {
        guard let user else { return }
        Task {
            try await UserManager.shared.removeFavoriteMovie(userId: user.userId)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }

}


struct ProfileView: View {
    @Binding var showSignInOptions: Bool
    @StateObject private var viewModel = ProfilViewModel()
    
    let preferenceOptions: [String] = ["Sports", "Movies", "Books"]
    private func preferenceIsSelected(text: String) -> Bool {
        viewModel.user?.preferences?.contains(text) == true
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                AdwumaXView(text1: "Profile", text2: "", size: Consts.Title.fontSize2)
                    .padding(.leading).padding(.top)
                Spacer()
                NavigationLink {
                    SettingsView(showSignInOptions: $showSignInOptions)
                } label: {
                    Image(systemName: "gear").font(.headline)
                }
                .padding(.trailing).padding(.top)
                
            }
            Divider().background(Color.primary1)
            List {
                if let user = viewModel.user {
                    Text("UserId: \(user.userId)")
                    if let email = user.email {
                        Text("UserEmail: \(email)")
                    }
                    Button(action: {
                        viewModel.togglePremiumStatus()
                    }, label: {
                        Text("User is premium: \((user.isPremium ?? false).description.capitalized)")
                    })
                    
                    VStack {
                        HStack {
                            ForEach (preferenceOptions, id: \.self) { string in
                                Button(string, action: {
                                    if preferenceIsSelected(text: string) {
                                        viewModel.removeUserPreference(text: string)
                                    } else {
                                        viewModel.addUserPreference(text: string)
                                    }
                                })
                                .font(.headline).buttonStyle(.borderedProminent)
                                .tint(preferenceIsSelected(text: string) ? .green : .red)
                            }
                        }
                        Text("User preferences: \((user.preferences ?? []).joined(separator: ", "))")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Button(action: {
                        if user.favoriteMovie == nil {
                            viewModel.addFavouriteMovie()
                        } else {
                            viewModel.removeFavouriteMovie()
                        }
                    }, label: {
                        Text("Favorite Movie: \((user.favoriteMovie?.title ?? ""))")
                    })
                }
                
            }
            .task {
                try? await viewModel.loadCUrrentUser()
            }
        }
        .tabItem {
            Label("Profile", systemImage: "person")
        }
    }
}




#Preview {
    ProfileView(showSignInOptions: .constant(false))
}
