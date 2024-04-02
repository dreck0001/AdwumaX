//
//  HomeView.swift
//  Adwumax1
//
//  Created by Denis on 3/19/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationStack {
                HStack {
                    AdwumaXView(text1: "Adwuma", text2: "X", size: Consts.Title.fontSize2)
                    Spacer()
                    NavigationLink {
                        Text("Notifications view")
                    } label: {
                        Image(systemName: "bell").font(.headline)
                    }
                }
                .padding(.leading).padding(.trailing).padding(.top)
                ScrollableTabView()
            
        }
        .tabItem {
            Label("Home", systemImage: "list.bullet.below.rectangle")
        }
    }
}

#Preview {
    HomeView()
}

struct CardView: View {
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .cornerRadius(8)
            .shadow(radius: 5)
            .frame(height: 150) // Adjust the height as needed
            .overlay(
                Text("Card Content")
                    .foregroundColor(.white)
            )
    }
}

struct ScrollableTabView: View {
    let tabs = ["For you", "New Projects", "New Requests", "Top Services", "Discover"]
    @State private var selectedTabIndex = 0
    
    var body: some View {
        VStack {
            CustomTabs(tabs: tabs, selectedTabIndex: $selectedTabIndex)
//                .padding(.top)
            TabView(selection: $selectedTabIndex) {
                ForEach(tabs.indices, id: \.self) { index in
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(0..<5) { _ in // Assuming 5 cards per tab
                                Test()
//                                CardView()
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: selectedTabIndex)
        }
    }
}
struct CustomTabs: View {
    let tabs: [String]
    @Binding var selectedTabIndex: Int
    @Environment(\.colorScheme) var colorScheme
    @Namespace private var namespace

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                HStack(spacing: 20) {
                    ForEach(tabs.indices, id: \.self) { index in
                        Text(tabs[index])
                            .id(index) // Ensure each Text view can be uniquely identified for scrollTo
                            .foregroundColor(selectedTabIndex == index ? (colorScheme == .dark ? .white : .black) : .gray)
                            .padding(.vertical, 10)
                            .background(
                                VStack {
                                    Spacer()
                                    if selectedTabIndex == index {
                                        Rectangle()
//                                            .fill(colorScheme == .dark ? Color.white : Color.black)
                                            .fill(Color.primaryBlueGreen)
                                            .frame(height: 2)
                                            .matchedGeometryEffect(id: "underline", in: namespace)
                                    } else {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 2)
                                    }
                                }
                            )
                            .onTapGesture {
                                withAnimation {
                                    selectedTabIndex = index
                                }
                            }
                    }
                }
                .padding(.horizontal)
                .onChange(of: selectedTabIndex) { _, newIndex in
                    withAnimation {
                        value.scrollTo(newIndex, anchor: .center)
                    }
                }
            }
        }
    }
}
