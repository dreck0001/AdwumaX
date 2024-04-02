//
//  NetworkView.swift
//  Adwumax1
//
//  Created by Denis on 3/19/24.
//

import SwiftUI

struct NetworkView: View {
    var body: some View {
        NavigationStack {
            HStack {
                AdwumaXView(text1: "Net", text2: "work", size: Consts.Title.fontSize2)
                    .padding(.leading).padding(.top)
                Spacer()
            }
            List {
                Text("Explore and connect with professionals")
                Text("Manage professional network")
                Text("Share and receive virtual business cards via QR codes")
            }
        }
        .tabItem { Label(
            title: { Text("Network") },
            icon: { Image(systemName: "person.line.dotted.person") }
        ) }
    }
    
}

#Preview {
    NetworkView()
}
