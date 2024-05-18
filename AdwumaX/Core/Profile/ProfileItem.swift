//
//  ProfileItem.swift
//  AdwumaX
//
//  Created by Denis on 5/14/24.
//

import SwiftUI

struct ProfileItem: View {
    
    let image: String
    let title: String
    let preview: String
    let rightIcon: String
    
    var body: some View {
        HStack {
            Image(systemName: image).foregroundColor(.gray)
            Text(title).foregroundStyle(.primary)
            Spacer()
            Text(preview).foregroundColor(.gray)
            Image(systemName: rightIcon).foregroundColor(.gray)
        }
    }
}

#Preview {
    ProfileItem(image: "doc", title: "Title", preview: "", rightIcon: "chevron.right")
}
