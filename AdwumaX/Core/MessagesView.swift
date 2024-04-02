//
//  MessagesView.swift
//  Adwumax1
//
//  Created by Denis on 3/19/24.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        NavigationStack {
            HStack {
                AdwumaXView(text1: "Messages", text2: "", size: Consts.Title.fontSize2)
                    .padding(.leading).padding(.top)
                Spacer()
                NavigationLink {
                    Text("Add a project")
                } label: {
                    Image(systemName: "bell.badge").font(.headline)
                }
                .padding(.trailing).padding(.top)
            }
            List {
                Text("All in-app messaging")
                Text("Direct messages and communication")
                Text("Notifications and alerts on project updates and connections")
            }
        }
        .tabItem {
            Label("Messages", systemImage: "message")
        }
    }
}



#Preview {
    MessagesView()
}
