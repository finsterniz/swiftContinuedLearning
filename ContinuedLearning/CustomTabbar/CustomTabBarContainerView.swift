//
//  CustomTabBarContainerView.swift
//  ContinuedLearning
//
//  Created by a on 22.10.24.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content){
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                content
            }
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

struct CustomTabBarContainerViewPreview: View {
    static let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", title: "Home", color: .red),
        TabBarItem(iconName: "heart", title: "Favorites", color: .blue),
        TabBarItem(iconName: "person", title: "Profile", color: .green)
    ]
    
    var body: some View {
        CustomTabBarContainerView(selection: .constant(CustomTabBarContainerViewPreview.tabs.first!)) {
            Color.red
        }
    }
}

#Preview {
    CustomTabBarContainerViewPreview()
}
