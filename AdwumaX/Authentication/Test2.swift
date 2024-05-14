//
//  Test2.swift
//  Adwumax1
//
//  Created by Denis on 3/24/24.
//

//import SwiftUI
//
//@MainActor
//final class ProfilViewwModel: ObservableObject {
//    
//    @Published private(set) var user: DBUser? = nil
//    func loadCUrrentUser() async throws {
//        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
//    }
//    @Published var authProviders: [AuthProviderOption] = []
//    func loadAuthProviders() {
//        if let providers = try? AuthenticationManager.shared.getProviders() {
//            authProviders = providers
//        }
//    }
//}
//
//struct ProfileVieww: View {
//    
//    @Binding var showSignInOptions: Bool
//    @State private var isShowingEditPersonalView = false
//    @StateObject private var viewModel = ProfilViewwModel()
//    
//    private func getGeneralDestinationView(for title: String) -> AnyView {
//        switch title {
//        case "Settings":
//            return AnyView(SettingsView(showSignInOptions: $showSignInOptions))
//        case "About":
//            return AnyView(Text("About Details"))
//        default:
//            // Fallback view if no match is found
//            return AnyView(Text("Detail for \(title)"))
//        }
//    }
//    // Sample data for the second section
//    let secondSectionItems: [SecondSectionItem] = [
//        SecondSectionItem(icon: "gear", title: "Settings"),
//        SecondSectionItem(icon: "info.circle", title: "About")
//    ]
//    
//    let profile: Profile = .standard
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                ZStack(alignment: .top) {
//                    profile.backgroundPhoto
//                        .resizable()
//                        .frame(height: 150)
//                        .ignoresSafeArea()
//                    
//                    VStack(alignment: .center, spacing: 4) {
//                        profile.profilePhoto
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                            .clipShape(.circle)
//                            .padding(4)
//                            .background {
//                                Circle()
//                                    .foregroundStyle(.background)
//                            }
//                        
//                        Text(profile.name)
//                            .font(.title)
//                            .bold()
//                        Text("Active since - \(profile.getFormattedDate(with: 1))")
//                            .font(.subheadline)
//                            .foregroundStyle(.secondary)
//                        
//                        Spacer()
//                        
//                        
//                        
//                        VStack(alignment: .leading, spacing: 10) {
//                            HStack {
//                                Text(ProfileSection.personal.rawValue)
//                                    .font(.headline)
//                                    .padding(.vertical)
//                                Spacer()
//                                Button(
//                                    action: {
//                                        isShowingEditPersonalView = true
//                                    },
//                                    label: {
//                                        Label("Edit", systemImage: "highlighter")
//                                    })
//                                .fullScreenCover(isPresented: $isShowingEditPersonalView, content: {
//                                    EditPersonalView(isPresented: $isShowingEditPersonalView)
//                                })
//                            }
//                            if let user = viewModel.user {
//                                if viewModel.authProviders.contains(.email) {
//                                    HStack {
//                                        Image(systemName: "envelope").foregroundColor(.blue)
//                                        Text("Email")
//                                        Spacer()
//                                        Text(user.email ?? "").foregroundColor(.gray)
//                                    }
//                                    Divider()
//                                }
//                                HStack {
//                                    Image(systemName: "phone").foregroundColor(.blue)
//                                    Text("Phone")
//                                    Spacer()
//                                    Text(user.phone ?? "").foregroundColor(.gray)
//                                }
//                                Divider()
//                                HStack {
//                                    Image(systemName: "location").foregroundColor(.blue)
//                                    Text("Location")
//                                    Spacer()
//                                    Text(user.location ?? "").foregroundColor(.gray)
//                                }
//                                Divider()
//                            }
//                            Text(ProfileSection.general.rawValue)
//                                .font(.headline)
//                                .padding(.vertical)
//                            
//                            ForEach(secondSectionItems, id: \.title) { item in
//                                NavigationLink(destination: getGeneralDestinationView(for: item.title))
//                                {
//                                    HStack {
//                                        Image(systemName: item.icon)
//                                            .foregroundColor(.green)
//                                        Text(item.title)
//                                        Spacer()
//                                        Image(systemName: "chevron.right")
//                                            .foregroundColor(.gray)
//                                    }
//                                }
//                                Divider()
//                            }
//                        }
//                        .padding()
//                        Spacer()
//                        
//                    }
//                    .padding()
//                    .offset(y: 75)
//                    
//                }
//            }
//            .ignoresSafeArea()
//            .task { try? await viewModel.loadCUrrentUser() ; print(viewModel.user?.phone ?? "---") }
//            .onAppear { viewModel.loadAuthProviders()}
//        }
//        .tabItem {
//            Label("Profilee", systemImage: "person")
//        }
//    }
//}
//
//#Preview {
//    ProfileVieww(showSignInOptions: .constant(false))
//}
//
//struct Profile {
//    let name: String
//    let backgroundPhoto: Image
//    let profilePhoto: Image
//    let activeSince: Date
//    
//    func getFormattedDate(with formatOption: Int) -> String {
//        let dateFormatter = DateFormatter()
//        switch formatOption {
//        case 1: dateFormatter.dateFormat = "MMM y"
//        default: dateFormatter.dateFormat = "yyyy-MM-dd"
//        }
//        return dateFormatter.string(from: activeSince)
//    }
//}
//
//extension Profile {
//    static var standard: Profile {
//        Profile(
//            name: "Denis Ansah",
//            backgroundPhoto: Image(.screenshot20240409At14640PM),
//            profilePhoto: Image(.profile),
//            activeSince: Date()
//        )
//    }
//}
//
//
//// Define your data structures
//struct PersonalSectionItem {
//    let icon: String
//    let title: String
//    let detail: String
//}
//
//struct SecondSectionItem {
//    let icon: String
//    let title: String
//}
//
//enum ProfileSection: String {
//    case personal = "Personal Information"
//    case general = "General"
//}
//
//
