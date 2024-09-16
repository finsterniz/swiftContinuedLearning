//
//  ScrollViewPagingBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 15.09.24.
//

import SwiftUI

struct ScrollViewPagingBootcamp: View {
    @State private var scrollPosition: Int? = nil
    
    var body: some View {
        VStack{
            Button("Scroll to") {
                scrollPosition = Int.random(in: 0..<30)
            }
            
            ScrollView(.horizontal){
                HStack(spacing: 0, content: {
                    ForEach(1..<30) { i in
                        Rectangle()
                            .frame(width: 300, height: 300)
                            .overlay(content: {
                                Text("\(i)")
                                    .foregroundStyle(.white)
                            })
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(i)
                            .scrollTransition(.interactive) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .offset(y: phase.isIdentity ? 0 : -100)
                                
                            }

                            // to enable this feature, the spacing of vstack must be 0, use padding  inside the Foreach, and use ignore safeArea outside of Scrollview
                    }
                })
            }
            .ignoresSafeArea()
            .scrollBounceBehavior(.basedOnSize)
            
            .scrollTargetLayout()
    //        .scrollTargetBehavior(.viewAligned) // when stop scrolling, always align
            .scrollTargetBehavior(.paging) // scroll just like page
            .scrollPosition(id: $scrollPosition, anchor: .center)
            .animation(.spring, value: scrollPosition)
        }
        
        
//        ScrollView{
//            VStack(spacing: 0, content: {
//                ForEach(1..<30) { i in
//                    Rectangle()
////                        .frame(width: 300, height: 300)
//                        .overlay(content: {
//                            Text("\(i)")
//                                .foregroundStyle(.white)
//                        })
//                        .frame(maxWidth: .infinity)
//                    
//                        .padding(.vertical, 10)
//                        .containerRelativeFrame(.vertical, alignment: .center)
//                        // to enable this feature, the spacing of vstack must be 0, use padding  inside the Foreach, and use ignore safeArea outside of Scrollview
//                }
//            })
//        }
//        .ignoresSafeArea()
//        .scrollBounceBehavior(.basedOnSize)
//        
//        .scrollTargetLayout()
////        .scrollTargetBehavior(.viewAligned) // when stop scrolling, always align
//        .scrollTargetBehavior(.paging) // scroll just like page
//        
    }
}

#Preview {
    ScrollViewPagingBootcamp()
}
