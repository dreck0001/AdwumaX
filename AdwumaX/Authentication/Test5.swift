////
////  Test5.swift
////  AdwumaX
////
////  Created by Denis on 4/10/24.
////
//
//import SwiftUI
//
//struct Test5: View {
//    let firstSectionItems: [FirstSectionItem] = [
//        FirstSectionItem(icon: "envelope", title: "Email", detail: "info@adwumax.com"),
//        FirstSectionItem(icon: "phone", title: "Phone", detail: "+1 (508) 615-6145"),
//        FirstSectionItem(icon: "location", title: "Location", detail: "Achimota")
//    ]
//    
//    let secondSectionItems: [SecondSectionItem] = [
//        SecondSectionItem(icon: "gear", title: "Settings"),
//        SecondSectionItem(icon: "info.circle", title: "About")
//    ]
//    
//    let profile: Profile = .standard
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .center, spacing: 4) {
//                profile.backgroundPhoto
//                    .resizable()
//                    .frame(height: 150)
//                    .ignoresSafeArea()
//                
//                profile.profilePhoto
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 150, height: 150)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
//                    .shadow(radius: 7)
//                    .offset(y: -75) // Adjust as needed
//                    .padding(.bottom, -75) // Adjust as needed
//                
//                Text(profile.name)
//                    .font(.title)
//                    .bold()
//                
//                Text("Active since - \(profile.getFormattedDate(with: 1))")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                    .padding(.bottom)
//                
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Personal Information")
//                        .font(.headline)
//                        .padding(.vertical)
//                    
//                    ForEach(firstSectionItems, id: \.title) { item in
//                        HStack {
//                            Image(systemName: item.icon)
//                                .foregroundColor(.blue)
//                            Text(item.title)
//                            Spacer()
//                            Text(item.detail)
//                                .foregroundColor(.gray)
//                        }
//                        Divider()
//                    }
//                    
//                    Text("Second Section")
//                        .font(.headline)
//                        .padding(.vertical)
//                    
//                    ForEach(secondSectionItems, id: \.title) { item in
//                        HStack {
//                            Image(systemName: item.icon)
//                                .foregroundColor(.green)
//                            Text(item.title)
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                                .foregroundColor(.gray)
//                        }
//                        Divider()
//                    }
//                }
//                .padding()
//            }
//            .padding(.top, 1) // This small padding ensures the top edge is nicely aligned
//        }
//        .edgesIgnoringSafeArea(.top) // This makes the background photo extend into the safe area
//    }
//}
//
//// Include the rest of your code here (Profile, FirstSectionItem, SecondSectionItem structures)
//
//
////struct Test5: View {
////    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////    }
////}
//
//#Preview {
//    Test5()
//}
