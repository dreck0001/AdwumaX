//
//  MotoView.swift
//  Adwumax1
//
//  Created by Denis on 3/9/24.
//

import SwiftUI

struct MotoView: View {
    var body: some View {
        
        HStack {
            Spacer()
            Group {
                Text("Taking Adwuma to the") +
                Text(" MAX!").foregroundColor(Color.primaryBlueGreen)
            }
            .multilineTextAlignment(.center)
            .font(.custom("Baskerville", fixedSize: CGFloat(Consts.Icon.fontSize)))
            Spacer()
        }
    }
}

#Preview {
    MotoView()
}
