//
//  ViewBuilderBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 16.10.24.
//

import SwiftUI

struct HeaderViewGeneric<Content: View>: View {
    let title: String
    let content: Content
    
    // content: ()->Content, 意思是content是一个func产生一个Content类型, 也就是View的方法
    // @ViewBuilder意思是这个会产生一个View, 这一类方法都需要用 @ViewBuilder来标记
    init(title: String, @ViewBuilder content: ()->Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        })
        .padding()
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        HeaderViewGeneric(title: "Generic Title") {
            HStack{
                Text("Hi")
                Text("Hi")
                Text("Hi")
            }
        }
    }
}

#Preview {
//    ViewBuilderBootcamp()
    LocalViewBuilder(type: .three)
}

struct LocalViewBuilder: View {
    
    enum ViewType{
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        headerSection
    }
    
    // 这里必须加上 @ViewBuilder, 否则会警告: Branches have mismatching types 'some View' (type of 'LocalViewBuilder.viewOne') and 'some View' (type of 'LocalViewBuilder.viewThree')
    @ViewBuilder private var headerSection: some View{
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View{
        Text("One!")
    }
    
    private var viewTwo: some View{
        VStack{
            Text("TWOOO")
            Image(systemName: "bolt")
        }
    }
    
    private var viewThree: some View{
        Image(systemName: "bolt")
    }
}
