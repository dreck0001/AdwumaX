//
//  AdwumaxView.swift
//  Adwumax1
//
//  Created by Denis on 3/1/24.
//

import SwiftUI

struct AdwumaXView: View {
    @State var text1: String
    @State var text2: String
    @State var size: CGFloat
    init(text1: String, text2: String, size: CGFloat) {
        self.text1 = text1
        self.text2 = text2
        self.size = size
    }
    var body: some View {
        
        HStack(spacing: 0) {
            Text(text1)
            Text(text2)
                .foregroundColor(Color.primary1)
        }
        .font(.custom(Consts.Title.fontName, fixedSize: size))
        .font(.largeTitle)
    }
}

#Preview {
    AdwumaXView(text1: "Adwuma", text2: "X", size: Consts.Icon.fontSize)
}
