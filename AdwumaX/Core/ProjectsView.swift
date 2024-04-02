//
//  ProjectsView.swift
//  Adwumax1
//
//  Created by Denis on 3/19/24.
//

import SwiftUI

struct ProjectsView: View {
    var body: some View {
        NavigationStack{
            HStack {
                AdwumaXView(text1: "Projects", text2: "", size: Consts.Title.fontSize2)
                    .padding(.leading).padding(.top)
                Spacer()
                NavigationLink {
                    Text("Add a project")
                } label: {
                    Image(systemName: "slider.horizontal.3").font(.headline)
                }
                .padding(.trailing).padding(.top)
                NavigationLink {
                    Text("Add a project")
                } label: {
                    Image(systemName: "plus").font(.headline)
                }
                .padding(.trailing).padding(.top)
            }
            Divider()
            List {
                Text("List of ongoing projects and history for service providers")
                Text("Active inquiries and bookings for users")
                Text("Post and browse projects")
            }
        }
        .tabItem { Label(
            title: { Text("Projects") },
            icon: { Image(systemName: "wrench.and.screwdriver.fill") }
        ) }
    }
}

#Preview {
    ProjectsView()
}
