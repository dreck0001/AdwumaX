//
//  ProfileVieww.swift
//  AdwumaX
//
//  Created by Denis on 4/17/24.
//

import SwiftUI

@MainActor
final class ProfilViewwModel: ObservableObject {
    
    @Published var number: String = ""
    @Published var countryCode : String = "+233"
    @Published var countryFlag : String = "🇬🇭"
    @Published var countryPattern : String = "### ### ####"
    @Published var countryLimit : Int = 5
    
    @Published private(set) var user: DBUser? = nil
    func loadCUrrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    @Published var authProviders: [AuthProviderOption] = []
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    func addLocation(location: String) {
        guard let user else { return }
        let location = Location(id: "1", location: location, allowLocationEntry: true)
        Task {
            try await UserManager.shared.addLocation(userId: user.userId, userLocation: location)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    func updatePhone() {
        print("Saving New Phone...")
        guard let user else { return }
        let phone = Phone(id: UUID().uuidString, number: number, countryCode: countryCode, countryFlag: countryFlag, countryPattern: countryPattern, countryLimit: countryLimit)
        Task {
            try await UserManager.shared.updatePhone(userId: user.userId, phone: phone)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    func phoneIsValid() -> Bool {
        
        return true
    }
}

struct ProfileVieww: View {
    
    @Binding var showSignInOptions: Bool
    @State private var isShowingEditPersonalView = false
    //    @StateObject private var viewModel = ProfilViewwModel()
    @ObservedObject var viewModel: ProfilViewwModel
    
    
    private func getGeneralDestinationView(for title: String) -> AnyView {
        switch title {
        case "Settings":
            return AnyView(SettingsView(showSignInOptions: $showSignInOptions))
        case "About":
            return AnyView(Text("About Details"))
        default:
            // Fallback view if no match is found
            return AnyView(Text("Detail for \(title)"))
        }
    }
    // Sample data for the second section
    let secondSectionItems: [SecondSectionItem] = [
        SecondSectionItem(icon: "gear", title: "Settings"),
        SecondSectionItem(icon: "info.circle", title: "About")
    ]
    
    let profile: Profile = .standard
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack(alignment: .top) {
                    profile.backgroundPhoto
                        .resizable()
                        .frame(height: 150)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .center, spacing: 4) {
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
                        
                        Text(profile.name)
                            .font(.title)
                            .bold()
                        Text("Active since - \(profile.getFormattedDate(with: 1))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(ProfileSection.personal.rawValue)
                                    .font(.headline)
                                    .padding(.vertical)
                                Spacer()
                            }
                            if let user = viewModel.user {
                                if viewModel.authProviders.contains(.email) {
                                    NavigationLink(destination: EditEmailView()) {
                                        ProfileItem(image: "envelope", title: "Email", preview: user.email ?? "", rightIcon: "chevron.right")
                                    }
                                } else {
                                    ProfileItem(image: "envelope", title: "Insert google/apple image", preview: user.email ?? "", rightIcon: "")
                                }
                                Divider()
                                
                                NavigationLink(destination: EditPhoneView(viewModel: ProfilViewwModel())) {
                                    ProfileItem(image: "phone", title: "Phone", preview: (user.phone?.countryCode ?? "") + " " + (user.phone?.number ?? ""), rightIcon: "chevron.right")
//                                    HStack {
//                                        Image(systemName: "phone").foregroundColor(.blue)
//                                        Text("Phone")
//                                        Spacer()
//                                        Text(user.phone?.countryCode ?? "").foregroundColor(.gray)
//                                        Text(user.phone?.number ?? "").foregroundColor(.gray)
//                                        Image(systemName: "chevron.right").foregroundColor(.gray)
//                                    }
                                }
                                Divider()
                                NavigationLink(destination: AnyView(Text("Location Details"))) {
                                    ProfileItem(image: "location", title: "Location", preview: user.userLocation?.location ?? "", rightIcon: "chevron.right")
                                }
//                                HStack {
//                                    Image(systemName: "location").foregroundColor(.blue)
//                                    Text("Location")
//                                    Spacer()
//                                    Text(user.userLocation?.location ?? "").foregroundColor(.gray)
//                                    Image(systemName: "chevron.right").foregroundColor(.gray)
//                                }
                                Divider()
                            }
                            
                            Text(ProfileSection.general.rawValue)
                                .font(.headline)
                                .padding(.vertical)
                            
                            ForEach(secondSectionItems, id: \.title) { item in
                                NavigationLink(destination: getGeneralDestinationView(for: item.title))
                                {
                                    HStack {
                                        Image(systemName: item.icon)
                                            .foregroundColor(.green)
                                        Text(item.title)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                }
                                Divider()
                            }
                            
                            Text(ProfileSection.app.rawValue)
                                .font(.headline)
                                .padding(.vertical)
                        }
                        .padding()
                        Spacer()
                    }
                    .padding()
                    .offset(y: 75)
                }
            }
            .ignoresSafeArea()
            .navigationTitle("Profile")
            .toolbar(.hidden)
            .task { try? await viewModel.loadCUrrentUser(); print("-task") }
            .onAppear { viewModel.loadAuthProviders(); print("-onAppear") }
        }
        .tabItem { Label("Profilee", systemImage: "person") }
    }
}

#Preview {
    ProfileVieww(showSignInOptions: .constant(false), viewModel: ProfilViewwModel())
}

struct Profile {
    let name: String
    let backgroundPhoto: Image
    let profilePhoto: Image
    let activeSince: Date
    
    func getFormattedDate(with formatOption: Int) -> String {
        let dateFormatter = DateFormatter()
        switch formatOption {
        case 1: dateFormatter.dateFormat = "MMM y"
        default: dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        return dateFormatter.string(from: activeSince)
    }
}

struct SuccessView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.green)
            Text("Phone saved successfully")
                .font(.title)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.black.opacity(0.75))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

extension Profile {
    static var standard: Profile {
        Profile(
            name: "Denis Ansah",
            backgroundPhoto: Image(.screenshot20240409At14640PM),
            profilePhoto: Image(.profile),
            activeSince: Date()
        )
    }
}


// Define your data structures
struct PersonalSectionItem {
    let icon: String
    let title: String
    let detail: String
}

struct SecondSectionItem {
    let icon: String
    let title: String
}

enum ProfileSection: String {
    case personal = "Personal Information"
    case general = "General"
    case app = "App Information"
}
