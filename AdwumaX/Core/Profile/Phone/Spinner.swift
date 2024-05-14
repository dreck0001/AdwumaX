//
//  Spinner.swift
//  AdwumaX
//
//  Created by Denis on 5/9/24.
//

import SwiftUI

struct Spinner: View {
    @State private var isSaving = false // State to manage the button's loading appearance

    var body: some View {
        Button(action: {
            isSaving = true
            // Simulate a save action with a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                print("now")
                isSaving = false
            }
        }) {
            if isSaving {
                HStack {
                    ProgressView() // Spinner
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    Text("  Saving...")
                        .foregroundColor(.white)
                }
            } else {
                Text("Save")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.red, lineWidth: 2)
        )
        .padding()
        .tabItem {
            Label("Spinner", systemImage: "square.and.arrow.up")
        }
    }
}

#Preview {
    Spinner()
}
