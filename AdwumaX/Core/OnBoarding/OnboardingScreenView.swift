//
//  OnboardingScreenView.swift
//  AdwumaX
//
//  Created by Denis on 4/2/24.
//

import SwiftUI

struct OnboardingScreenView: View {
    let data: OnboardingData
    let isLastScreen: Bool
    let action: () -> Void

    var body: some View {
        VStack {
            Spacer()
            
            Text(data.title)
                .font(.title)
                .padding(.top, 20)
                .frame(height: 100)
            Spacer()
            Image(data.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(data.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(height: 150)
            
            if isLastScreen {
                Button(action: action) {
                    Text("Let's get started").button1()
                }.padding()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    OnboardingScreenView(data: onboardingScreens.last!, isLastScreen: true, action: {})
}
