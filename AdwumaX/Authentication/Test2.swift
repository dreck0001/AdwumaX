//
//  Test2.swift
//  Adwumax1
//
//  Created by Denis on 3/24/24.
//

import SwiftUI

struct Test2: View {
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationStack {
                HStack {
                    AdwumaXView(text1: "Adwuma", text2: "X", size: Consts.Title.fontSize2)
                    Spacer()
                    NavigationLink {
                        Text("Notifications view")
                    } label: {
                        Image(systemName: "bell").font(.headline)
                    }
                }
                .padding(.leading).padding(.trailing).padding(.top)
            Text("Main Body")
        }
    }
}

#Preview {
    Test2()
}
