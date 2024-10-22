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
    
    func body(content: Content) -> some View {
        content.preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View{
    func tabBarItem(tabs: TabBarItem)-> some View{
        self
            .modifier(TabBarItemViewModifier(tab: tabs))
    }
}
