//
//  EditEmailView.swift
//  AdwumaX
//
//  Created by Denis on 4/19/24.
//

import SwiftUI

@MainActor
final class EditEmailViewModel: ObservableObject {
    @Published var email: String = ""
    
    func onSave() {
        print("Saving New Email...")
    }
}

struct EditEmailView: View {
    
    @StateObject private var viewModel = EditEmailViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Edit Email").textTitle()
                Spacer()
                BorderedTextField(text: $viewModel.email, placeHolder: "Enter New Email", isSecure: false)
                Spacer()
                Button("Save") {
                    viewModel.onSave()
                    presentationMode.wrappedValue.dismiss()
                }.button1()
                    .padding()
                
            }
            //            .toolbar {
            //                ToolbarItem(placement: .topBarLeading) {
            //                    Button(
            //                        action: { print("Closing EditEmailView...") },
            //                        label: { Image(systemName: "xmark") }
            //                    )
            //                }
            //            }
            
        }
        .tabItem { Label("Email", systemImage: "pencil") }
    }
}

#Preview {
    EditEmailView()
}
