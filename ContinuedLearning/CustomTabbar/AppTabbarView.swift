//
//  AppTabbarView.swift
//  ContinuedLearning
//
//  Created by a on 22.10.24.
//

import SwiftUI

struct AppTabBarView: View {
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
//        defaultTabView
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.blue
                .tabBarItem(tabs: .home, selection: $tabSelection)
            
            Color.red
                .tabBarItem(tabs: .favorites, selection: $tabSelection)
            Color.green
                .tabBarItem(tabs: .profile, selection: $tabSelection)
        }
    }
}

extension AppTabBarView{
    private var defaultTabView: some View{
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    AppTabBarView()
}
