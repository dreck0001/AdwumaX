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
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
}

struct ProfileVieww: View {
    
    @Binding var showSignInOptions: Bool
    @State private var isShowingEditPersonalView = false
    //    @StateObject private var viewModel = ProfilViewwModel()
    @ObservedObject var viewModel: ProfilViewwModel
    
    private func getDestinationView(for title: String) -> AnyView {
        switch title {
        case "Settings":
            return AnyView(SettingsView(showSignInOptions: $showSignInOptions))
        case "About":
            return AnyView(Text("About Details"))
        case "My Services":
            return AnyView(Text("My Services Details"))
        case "Service Requests":
            return AnyView(Text("Service Requests Details"))
        case "Service History":
            return AnyView(Text("Service History Details"))
        case "Service Reviews":
            return AnyView(Text("Service Reviews Details"))
        case "Favorite Services":
            return AnyView(Text("Favorite Services Details"))
        case "Availability":
            return AnyView(Text("Availability Details"))
        case "Pricing Plans":
            return AnyView(Text("Pricing Plans Details"))
        case "Analytics":
            return AnyView(Text("Analytics Details"))
        case "Version":
            return AnyView(Text("App Version Details"))
        case "FAQ":
            return AnyView(Text("FAQ Details"))
        case "Privacy Policy":
            return AnyView(Text("Privacy Policy Details"))
        case "Terms of Service":
            return AnyView(Text("Terms of Service Details"))
        case "Community Guidelines":
            return AnyView(Text("Community Guidelines Details"))
        case "Legal":
            return AnyView(Text("Legal Details"))
        case "Contact Support":
            return AnyView(Text("Contact Support Details"))
        case "Rate Us":
            return AnyView(Text("Rate Us Details"))
        default:
            // Fallback view if no match is found
            return AnyView(Text("Detail for \(title)"))
        }
    }
    
    // Sample data for the second section
    let generalSectionItems: [ProfileItem] = [
        ProfileItem(image: "gear", title: "Settings", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "info.circle", title: "About", preview: "", rightIcon: "chevron.right")
    ]
    let servicesSectionItems: [ProfileItem] = [
        ProfileItem(image: "briefcase", title: "My Services", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "tray", title: "Service Requests", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "clock.arrow.circlepath", title: "Service History", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "star", title: "Service Reviews", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "heart", title: "Favorite Services", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "calendar", title: "Availability", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "dollarsign.circle", title: "Pricing Plans", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "chart.bar", title: "Analytics", preview: "", rightIcon: "chevron.right")
    ]
    let appInformationSectionItems: [ProfileItem] = [
        ProfileItem(image: "doc.plaintext", title: "Version", preview: "1.0.0", rightIcon: ""),
        ProfileItem(image: "questionmark.circle", title: "FAQ", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "lock.shield", title: "Privacy Policy", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "doc.text.magnifyingglass", title: "Terms of Service", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "hand.raised.fill", title: "Community Guidelines", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "hammer", title: "Legal", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "envelope", title: "Contact Support", preview: "", rightIcon: "chevron.right"),
        ProfileItem(image: "star.bubble", title: "Rate Us", preview: "", rightIcon: "chevron.right")
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
                                }
                                Divider()
                                NavigationLink(destination: AnyView(Text("Location Details"))) {
                                    ProfileItem(image: "location", title: "Location", preview: user.userLocation?.location ?? "", rightIcon: "chevron.right")
                                }
                                
                                Divider()
                            }
                            
                            Text(ProfileSection.general.rawValue)
                                .font(.headline)
                                .padding(.vertical)
                            
                            ForEach(generalSectionItems, id: \.title) { item in
                                NavigationLink(destination: getDestinationView(for: item.title))
                                {
                                    ProfileItem(image: item.image, title: item.title, preview: item.preview, rightIcon:item.rightIcon)
                                }
                                Divider()
                            }
                            Text(ProfileSection.services.rawValue)
                                .font(.headline)
                                .padding(.vertical)
                            ForEach(servicesSectionItems, id: \.title) { item in
                                NavigationLink(destination: getDestinationView(for: item.title))
                                {
                                    ProfileItem(image: item.image, title: item.title, preview: item.preview, rightIcon:item.rightIcon)
                                }
                                Divider()
                            }
                            Text(ProfileSection.app.rawValue)
                                .font(.headline)
                                .padding(.vertical)
                            ForEach(appInformationSectionItems, id: \.title) { item in
                                NavigationLink(destination: getDestinationView(for: item.title))
                                {
                                    ProfileItem(image: item.image, title: item.title, preview: item.preview, rightIcon:item.rightIcon)
                                }
                                Divider()
                            }
                            Button("Log out") {
                                Task {
                                    do {
                                        try viewModel.signOut()
                                        showSignInOptions = true
                                    } catch {
                                        print(error)
                                    }
                                }
                            }.button4()
                            .padding(.top)
                            Spacer()
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
    case services = "Services"
    case app = "App Information"
}
