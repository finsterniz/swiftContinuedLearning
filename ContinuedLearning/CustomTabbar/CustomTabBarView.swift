//
//  CustomTabBarView.swift
//  ContinuedLearning
//
//  Created by a on 22.10.24.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Namespace private var namespace
    @Binding var selection: TabBarItem
    @State var localSelection: TabBarItem
    var body: some View {
        tabBarVersion2
            .onChange(of: selection) { oldValue, newValue in
                withAnimation(.easeInOut){
                    localSelection = newValue
                }
            }
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
        .foregroundStyle(localSelection == item ? item.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(localSelection == item ? item.color.opacity(0.2) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func switchToTb(tab: TabBarItem){
        self.selection = tab
    }
    
    private var tabBarVersion1: some View{
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

fileprivate struct
CustomTabBarViewPreview: View {
    static let tabs: [TabBarItem] = [
        .home,
        .favorites,
        .profile
    ]
    @State var selection: TabBarItem = .home
    
    var body: some View {
        VStack{
            Spacer()
            CustomTabBarView(tabs: CustomTabBarViewPreview.tabs, selection: $selection, localSelection: CustomTabBarViewPreview.tabs.first!)
        }
    }
}

extension CustomTabBarView{
    private func tabview2(item: TabBarItem)->some View{
        VStack{
            Image(systemName: item.iconName)
                .font(.headline)
            
            Text(item.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                
        }
        .foregroundStyle(localSelection == item ? item.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack{
                if localSelection == item{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(item.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    private var tabBarVersion2: some View{
        HStack{
            ForEach(tabs, id: \.title) { tab in
                tabview2(item: tab)
                    .onTapGesture {
                        switchToTb(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}

#Preview {
    CustomTabBarViewPreview()
}
