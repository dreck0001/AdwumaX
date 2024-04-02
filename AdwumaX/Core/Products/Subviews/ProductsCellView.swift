//
//  ProductsCellView.swift
//  Adwumax1
//
//  Created by Denis on 3/28/24.
//

import SwiftUI

struct ProductsCellView: View {
    
    let product: Product
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
//                    HStack {
            AsyncImage(url: URL(string: product.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title ?? "n/a")
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text("Price: $" + String(product.price ?? 0))
                Text("Rating: " + String(product.rating ?? 0))
                Text("Category: " + (product.category ?? "n/a"))
                Text("Brand" + (product.brand ?? "n/a"))
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ProductsCellView(product: Product(id: 1, title: "asas", description: "sdcsdc", price: 23, discountPercentage: 34, rating: 3, stock: 34, brand: "Ddsdds", category: "fvsvs", thumbnail: "Sdsd", images: [""]))
}
