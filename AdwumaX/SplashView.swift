//
//  SplashView.swift
//  AdwumaX
//
//  Created by Denis on 3/31/24.
//

import SwiftUI

struct SplashView: View {
    
    //    @State var isActive: Bool = false
    @State var nameCount = 1
    let animationTime = 0.25
    
    var body: some View {
        switch nameCount {
        case 1:
            AdwumaXView(text1: "A", text2: "X", size: Consts.Icon.fontSize)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationTime * 4) {
                        withAnimation { self.nameCount += 1 }
                    }
                }
        case 2:
            AdwumaXView(text1: "Ad", text2: "X", size: Consts.Icon.fontSize)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
                        withAnimation { self.nameCount += 1 }
                    }
                }
        case 3:
            AdwumaXView(text1: "Adw", text2: "X", size: Consts.Icon.fontSize)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
                        withAnimation { self.nameCount += 1 }
                    }
                }
        case 4:
            AdwumaXView(text1: "Adwu", text2: "X", size: Consts.Icon.fontSize)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
                        withAnimation { self.nameCount += 1 }
                    }
                }
        case 5:
            AdwumaXView(text1: "Adwum", text2: "X", size: Consts.Icon.fontSize)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
                        withAnimation { self.nameCount += 1 }
                    }
                }
        case 6:
            AdwumaXView(text1: "Adwuma", text2: "X", size: Consts.Icon.fontSize)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation { self.nameCount += 1 }
                    }
                }
        default: ContentView()
        }
    }
    
}

#Preview {
    SplashView()
}
