//
//  ScrollViewOffsetPreferenceKey.swift
//  ContinuedLearning
//
//  Created by a on 19.10.24.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey{
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View{
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> Void)->some View{
        self
            .background(
                GeometryReader(content: { geometry in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
                })
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { value in
                action(value)
            })
        
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    var title: String = "New title here"
    @State var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack{
                titleSection
                    .opacity(Double(scrollViewOffset) / 75)
                    .onScrollViewOffsetChanged { offset in
                        scrollViewOffset = offset
                    }
                
                contentSection
            }
            .padding()
        }
        .overlay(content: {
            Text("\(scrollViewOffset)")
        })
        .overlay(smallTitleSection
            .opacity(scrollViewOffset < 40 ? 1.0 : 0)
                 ,alignment: .top)
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootcamp()
}

extension ScrollViewOffsetPreferenceKeyBootcamp{
    private var titleSection: some View{
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentSection: some View{
        ForEach(1..<30, id: \.self) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var smallTitleSection: some View{
        Text(title)
            .font(.headline)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .background(.blue)
    }
}
