//
//  Test2.swift
//  Adwumax1
//
//  Created by Denis on 3/24/24.
//

import SwiftUI

struct CustomButton {
    let title: String
    let url: URL
}

struct Profile4 {
    let name: String
    let headline: String
    let backgroundPhoto: Image
    let profilePhoto: Image
    let topVoice: String?
    let isVerified: Bool
    let contentCreatorTopics: [String]?
    let education: String
    let location: String
    let customButton: CustomButton?
    let numberOfFollowers: Int?
    let numberOfConnections: Int
}

extension Profile4 {
    var talksAbout: String? {
        guard let contentCreatorTopics, !contentCreatorTopics.isEmpty else { return nil }
        
        var lowerCasedTaggedTopics = contentCreatorTopics.map { "#\($0.lowercased())" }
        
        guard contentCreatorTopics.count > 1 else {
            return  "Talks about \(lowerCasedTaggedTopics.first!)"
        }
        
        let lastTaggedTopic = lowerCasedTaggedTopics.popLast()!
        
        return "Talks about " + lowerCasedTaggedTopics.joined(separator: ", ") + " and " + lastTaggedTopic
    }
    
    var numberOfConnectionsDescription: String {
        "\(min(numberOfConnections, 500))\(numberOfConnections > 500 ? "+" : "") connection\(numberOfConnections == 1 ? "" : "s")"
    }
    
    var numberOfFollowersDescription: String? {
        guard let numberOfFollowers else { return nil }
        return "\(numberOfFollowers.formatted(.number)) follower\(numberOfFollowers == 1 ? "" : "s")"
    }
}

struct ProfileView4: View {
    let profile: Profile4 = .standard
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            profile.backgroundPhoto
                .resizable()
                .frame(height: 150)
                .ignoresSafeArea()
            
            
            VStack(alignment: .leading, spacing: 4) {
                profile.profilePhoto
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .clipShape(.circle)
                    .padding(4)
                    .background {
                        Circle()
                            .foregroundStyle(.background)
                    }
                
                HStack {
                    Text(profile.name)
                        .font(.title)
                        .bold()
                    
                    if profile.isVerified {
                        Image(systemName: "checkmark.shield")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                            .foregroundStyle(.secondary)
                    }
                    
                    Image(systemName: "speaker.wave.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                        .foregroundStyle(.secondary)
                        .padding(.leading, 4)
                }
                .padding(.bottom)
                
                Text(profile.headline)
                    .padding(.bottom)
                if let topVoice = profile.topVoice {
                    HStack(spacing: 4) {
                        Image(systemName: "lightbulb.max")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14)
                            .fontWeight(.black)
                        Text(topVoice)
                            .fontWeight(.semibold)
                            .font(.caption)
                    }
                    .padding(6)
                    .padding(.horizontal, 3)
                    .background(Color(red: 248/255, green: 228/255, blue: 192/255))
                    .foregroundStyle(Color(red: 137/255, green: 92/255, blue: 31/255))
                    .clipShape(.capsule)
                    
                }
                
                if let talksAbout = profile.talksAbout {
                    Text(talksAbout)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top, 6)
                }
                
                Text(profile.education)
                    .font(.subheadline)
                    .foregroundStyle(.primary.opacity(0.9))
                    .padding(.top, 6)
                
                Text(profile.location)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if let customButton = profile.customButton {
                    Link(destination: customButton.url) {
                        HStack(spacing:  4) {
                            Text(customButton.title)
                            Image(systemName: "arrow.up.forward.square")
                        }
                    }
                    .bold()
                    .font(.subheadline)
                    .padding(.top, 8)
                }
                
                HStack(spacing: 0) {
                    if let numberOfFollowersDescription = profile.numberOfFollowersDescription {
                        Button(numberOfFollowersDescription) {
                            // ...
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(.secondary)
                        
                        Text("・")
                    }
                    
                    Button(profile.numberOfConnectionsDescription) {
                        // ...
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                }
                .bold()
                .font(.subheadline)
                .padding(.top, 8)
                
                HStack {
                    Button {
                        // ...
                    } label: {
                        Label("Follow", systemImage: "plus")
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                            .background(.link)
                            .foregroundStyle(.white)
                            .bold()
                            .clipShape(.capsule)
                    }
                    
                    Button {
                        // ...
                    } label: {
                        Label("Message", systemImage: "paperplane.fill")
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                            .foregroundStyle(.link)
                            .bold()
                            .overlay {
                                Capsule()
                                    .stroke(.link)
                            }
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ProfileView4()
}

extension Profile4 {
    static var standard: Profile4 {
        Profile4(
            name: "Lucas Kuipers",
            headline: """
Senior iOS Developer 
SwiftUI & UIKit | iOS, macOS, visionOS, iPadOs, watchOS & tvOS
""",
            backgroundPhoto: Image(.screenshot20240409At14640PM),
            profilePhoto: Image(.profile),
            topVoice: "Top Mobile Applications Voice",
            isVerified: true,
            contentCreatorTopics: ["iOS", "Apple", "Swift", "UIKit", "SwiftUI"],
            education: "Universidade Federal de Santa Catarina",
            location: "Florianópolis, Santa Catarina, Brazil",
            customButton: CustomButton(title: "Github", url: URL(string: "https://github.com/lucaswkuipers")!),
            numberOfFollowers: 9385,
            numberOfConnections: 7409
        )
    }
}
