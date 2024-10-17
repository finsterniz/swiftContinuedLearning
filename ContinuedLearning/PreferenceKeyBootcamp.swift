//
//  PreferenceKeyBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 17.10.24.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
    @State private var text: String = "Hello World"
    
    var body: some View {
        NavigationView(content: {
            VStack{
                SecondaryScreen(text: text)
            }
            .navigationTitle("Navigation Title")
        })
        // 通过设置这个, 无论是在parent还是child level的view里更改它, 都可以更改这个view里面的text
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        })
    }
}

extension View{
    
    // 将其打包为一个View的extension, 只要使用了就可以更改父视图的这个名为text的数据
    func customTitle(_ text: String) -> some View{
        // self
            // .preference(key: CustomTitlePreferenceKey.self, value: text)
        
        // 因为在View里面, 所以上下等同
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
    
}

#Preview {
    PreferenceKeyBootcamp()
}

struct SecondaryScreen: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            // 这里是child view, 但却可以更改parent view的数据
             .preference(key: CustomTitlePreferenceKey.self, value: "New value")
            .customTitle("Another title")
                // 直接用它就可以改变CustomTitlePreferenceKey修饰的preferenceKey
        
    }
}

struct CustomTitlePreferenceKey: PreferenceKey{
    
    static let defaultValue: String = ""
    
    // 输入一个可改变类型的value: String, 并且输入一个闭包: () -> String, 闭包可以产生String
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}
