//
//  AccessibilityColorBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 12.09.24.
//

import SwiftUI

struct AccessibilityColorBootcamp: View {
    
    // 当用户打开: 设置->辅助功能->显示颜色与大小->降低透明度时, 这个值为true
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    // 当用户打开了增强对比度的时候
    // .standard or .increase
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    
    // 当用户打开了“不以颜色区分”
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    // 当用户打开了智能反转
    @Environment(\.accessibilityInvertColors) var invertColors
    
    
    var body: some View {
        NavigationStack{
            VStack {
                Button("Button 1") {
                }
                .foregroundColor(colorSchemeContrast == .increased ? .white : .primary)
                .buttonStyle(.borderedProminent)
                
                
                Button("Button 2") {
                }
                .foregroundColor(.primary)
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
                
                Button("Button 3") {
                }
                .foregroundColor(.primary)
                .buttonStyle(.borderedProminent)
                .tint(.green)
                
                Button("Button 4") {
                }
                .foregroundStyle(differentiateWithoutColor ? .white: .green)
                .foregroundColor(.primary)
                .buttonStyle(.borderedProminent)
                .tint(differentiateWithoutColor ? .black : .purple)
            }
            .font(.largeTitle)
//            .navigationTitle("Hi")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
        }
        
    }
}

#Preview {
    AccessibilityColorBootcamp()
}
