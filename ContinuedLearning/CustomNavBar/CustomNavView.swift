//
//  CustomNavView.swift
//  ContinuedLearning
//
//  Created by a on 12.11.24.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: ()->Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView(content: {
            CustomNavBarContainerView {
                content
            }
            .navigationBarHidden(true)
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    CustomNavView{
        Color.red.ignoresSafeArea()
    }
}
