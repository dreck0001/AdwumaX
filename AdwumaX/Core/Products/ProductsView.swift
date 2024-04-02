//
//  ProductsView.swift
//  Adwumax1
//
//  Created by Denis on 3/27/24.
//

import SwiftUI

@MainActor
final class ProductsViewModel: ObservableObject {
    
    @Published private(set) var products: [Product] = []
    
    func getAllProducts() async throws {
        self.products = try await ProductsManager.shared.getAllProducts()
    }
}

struct ProductsView: View {
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.products) { product in
                    ProductsCellView(product: product)
                }
            }
            .navigationTitle("Products")
            .task {
                try? await viewModel.getAllProducts()
            }
            
        }
        .tabItem {
            Label("Products", systemImage: "infinity")
        }
    }
}

#Preview {
    ProductsView()
}
