////
////  EditPersonalView.swift
////  AdwumaX
////
////  Created by Denis on 4/11/24.
////
//
//import SwiftUI
//
//@MainActor
//
//struct EditPersonalView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var isPresented: Bool
//    
//    @State private var email: String = ""
//    @State private var phone: String = ""
//    @State private var allowLocationEntry = false
//    @State private var modifyingLocation = false
//    @State private var location = ""
//    func startModifyingLocation() {
//        modifyingLocation = true
//        print("dddd")
//    }
//    func endModifyingLocation() {
//        modifyingLocation = false
//        print("aaaa")
//    }
//    @ObservedObject var viewModel: ProfilViewwModel
//
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                if let user = viewModel.user {
//                    if viewModel.authProviders.contains(.email) {
//                        Section("Email") {
//                            TextField(user.email ?? "Email", text: $email)
//                        }
//                    }
//                    Section("Phone Number") {
//                        TextField(user.phone ?? "Phone", text: $phone)
//                    }
//                    if let userLocation = user.userLocation {
//                        Section("Location: \(userLocation.location)") {
//                            if modifyingLocation {
//                                TextField("Enter Location", text: $location)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                                HStack {
//                                    Button(action: endModifyingLocation) {
//                                        Text("Enter").button3()
//                                    }
//                                    Button(action: endModifyingLocation) {
//                                        Text("Cancel").button2()
//                                    }
//                                }
//                            } else {
//                                HStack {
//                                    Button(action: startModifyingLocation) {
//                                        Text("Change").button1()
//                                    }
//                                    Button(action: startModifyingLocation) {
//                                        Text("Remove").button2()
//                                    }
//                                }
//                            }
//                        }
//                    } else {
//                        Section("Location") {
//                            Toggle("Allow Location Entry", isOn: $allowLocationEntry)
//                            if allowLocationEntry {
//                                TextField("Enter Location", text: $location)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                            } else {
//                                Text("Location entry is disabled.")
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("Edit Profile Details", displayMode: .inline)
//            .navigationBarItems(leading: Button("Cancel") {
//                // Action to perform on Cancel
//                presentationMode.wrappedValue.dismiss()
//            }, trailing: Button("Save") {
//                print("Updating phone!")
//                viewModel.updatePhone(newPhone: phone)
//                
//                print("Updating location!")
//                viewModel.addLocation(location: location)
//                
//                presentationMode.wrappedValue.dismiss()
//            })
//            .task { try? await viewModel.loadCUrrentUser() }
//            .onAppear { viewModel.loadAuthProviders() }
//        }
//    }
//}
//
//#Preview {
//    EditPersonalView(isPresented: .constant(true), viewModel: ProfilViewwModel())
//}
