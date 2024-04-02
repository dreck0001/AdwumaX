//
//  ClearButton.swift
//  Adwumax1
//
//  Created by Denis on 3/10/24.
//

import SwiftUI

//struct ClearButton: View {
//    var imageName: String
//    var buttonText: String
//
//    var body: some View {
//        Button(action: {
//            print("Custom Button Tapped")
//        }) {
//            HStack {
//                Image(systemName: imageName); Spacer()
//                Text(buttonText); Spacer()
//            }
//            .foregroundColor(.primary) // Adapts to light/dark mode
//        }
//        .padding()
//        .frame(height: 50) // Set minimum height for the button
//        .background(
//            RoundedRectangle(cornerRadius: 80)
//                .stroke(Color.primary, lineWidth: 2) // Border color adapts to light/dark mode
//        )
//        .padding(.horizontal) // Add padding to the left and right of the button
//
//    }
//}

struct ClearButton: View {
    var imageName: String
    var buttonText: String
    var isSysName: Bool = false

    var body: some View {
        HStack {
            if isSysName { Image(systemName: imageName) }
            else { 
                Image(imageName)
                    .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
            Spacer()
            Text(buttonText)
            Spacer()
        }
        .foregroundColor(.primary)
        .padding()
        .frame(height: 40)
        .background(
            RoundedRectangle(cornerRadius: 80)
                .stroke(Color.primary, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}



#Preview {
    ClearButton(imageName: "googleIcon", buttonText: "Sign up with Email")
}
