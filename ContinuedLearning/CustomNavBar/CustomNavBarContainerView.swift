//
//  CustomNavBarContainerView.swift
//  ContinuedLearning
//
//  Created by a on 12.11.24.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: ()->Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0){
            CustomNavbarView()
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    CustomNavBarContainerView {
        ZStack{
            Color.green.ignoresSafeArea()
            
            Text("Hello World")
                .foregroundStyle(.white)
        }
    }
}
