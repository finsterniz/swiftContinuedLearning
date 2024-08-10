//
//  MagnificationGestureBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 09.08.24.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        
        VStack{
            HStack(spacing: 6){
                Circle()
                    .frame(width: 40, height: 40)
                
                Text("Swiftful Learning")
                
                Spacer()
                
                Image(systemName: "ellipsis")
                
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            currentAmount = value - 1
                        })
                        .onEnded({ _ in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        })
                )
            
            HStack(spacing: 10){
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            
            Text("This is the caption for my photo!")
                .font(.callout)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
            
        }
        
        
        
        
//        Text("Hello, World!")
//            .font(.title)
//            .padding(40)
//            .background(Color.red.cornerRadius(10))
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged({ value in
//                        // currentAmount的初始值为1, 表示没有缩放
//                        currentAmount = value - 1
//                    })
//                    .onEnded({ value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    })
//            )
    }
}

#Preview {
    MagnificationGestureBootcamp()
}
