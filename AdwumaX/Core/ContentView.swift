//
//  ContentView.swift
//  Adwumax1
//
//  Created by Denis on 2/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInOptions: Bool = false
    
    var body: some View {
        TabView {
            HomeView()
            NetworkView()
            ProjectsView()
//            MessagesView()
            ProductsView()

            ProfileView(showSignInOptions: $showSignInOptions)
        }
        .accentColor(.primaryBlueGreen) // Change the accent color to red
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
    }
}


#Preview {
    ContentView()
}
