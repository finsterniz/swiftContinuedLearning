//
//  CustomTabBarView.swift
//  ContinuedLearning
//
//  Created by a on 22.10.24.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    var body: some View {
        HStack{
            ForEach(tabs, id: \.title) { tab in
                tabView(item: tab)
                    .onTapGesture {
                        switchToTb(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
    }
}

extension CustomTabBarView{
    private func tabView(item: TabBarItem)->some View{
        VStack{
            Image(systemName: item.iconName)
                .font(.headline)
            
            Text(item.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                
        }
        .foregroundStyle(selection == item ? item.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(selection == item ? item.color.opacity(0.2) : .gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func switchToTb(tab: TabBarItem){
        self.selection = tab
    }
}

struct TabBarItem: Hashable{
    let iconName: String
    let title: String
    let color: Color
}

fileprivate struct
CustomTabBarViewPreview: View {
    static let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", title: "Home", color: .red),
        TabBarItem(iconName: "heart", title: "Favorites", color: .blue),
        TabBarItem(iconName: "person", title: "Profile", color: .green)
    ]
    @State var selection: TabBarItem = TabBarItem(iconName: "house", title: "Home", color: .red)
    
    var body: some View {
        VStack{
            Spacer()
            CustomTabBarView(tabs: CustomTabBarViewPreview.tabs, selection: $selection)
        }
    }
}

#Preview {
    CustomTabBarViewPreview()
}
