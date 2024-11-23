//
//  TabBarItemsPreferenceKey.swift
//  ContinuedLearning
//
//  Created by a on 22.10.24.
//

import Foundation
import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey{
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue() // 每次变化时候, 都会添加新的值进去
    }
}


struct TabBarItemViewModifier: ViewModifier{
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View{
    func tabBarItem(tabs: TabBarItem, selection: Binding<TabBarItem>)-> some View{
        self
            .modifier(TabBarItemViewModifier(tab: tabs, selection: selection))
    }
}
