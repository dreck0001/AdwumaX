//
//  ContentView.swift
//  Adwumax1
//
//  Created by Denis on 2/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInOptions: Bool = false
    @State private var showOnboarding: Bool = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    var body: some View {
        TabView(selection: .constant(0)) {
            HomeView()
            NetworkView()
            ProjectsView()
//            MessagesView()
            ProductsView()
            ProfileView(showSignInOptions: $showSignInOptions)
        }
        .accentColor(.primaryBlueGreen)
        .onAppear(perform: {
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInOptions = authuser == nil
            if let authuser = authuser {
                print("ContentView: \(authuser)")
            }
        })
        .fullScreenCover(isPresented: $showSignInOptions, content: {
            AuthenticationView(showSignInView: $showSignInOptions)
        })
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView(isShowingOnboarding: $showOnboarding)
        }
        .onAppear {
            showOnboarding = !hasSeenOnboarding
        }
    }
}


#Preview {
    ContentView()
}
