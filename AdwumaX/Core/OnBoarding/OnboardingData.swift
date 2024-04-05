//
//  OnboardingData.swift
//  AdwumaX
//
//  Created by Denis on 4/3/24.
//

import Foundation

struct OnboardingData {
    let title: String
    let description: String
    let imageName: String
}

let onboardingScreens = [
    OnboardingData(title: "Connect with Experts", description: "Easily find skilled professionals ready to meet your service needs.", imageName: "onboarding1_connect"),
    OnboardingData(title: "Diverse Services", description: "From home repair to tech support, discover a wide range of services.", imageName: "onboarding2_services"),
    OnboardingData(title: "Hassle-Free Booking", description: "Quickly book appointments with just a few taps.", imageName: "onboarding3_booking"),
    OnboardingData(title: "Get Started Today", description: "Welcome to a world where quality services meet convenience. Simplify your life with just a tap. Ready to dive in?", imageName: "onboarding4_start")
]
