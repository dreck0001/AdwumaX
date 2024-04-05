//
//  OnboardingView.swift
//  AdwumaX
//
//  Created by Denis on 4/3/24.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isShowingOnboarding: Bool

    var body: some View {
        TabView {
            ForEach(onboardingScreens.indices, id: \.self) { index in
                OnboardingScreenView(
                    data: onboardingScreens[index],
                    isLastScreen: index == onboardingScreens.count - 1,
                    action: {
                        isShowingOnboarding = false
                    }
                )
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    OnboardingView(isShowingOnboarding: .constant(true))
}
