//
//  MaskBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 14.08.24.
//

import SwiftUI

struct MaskBootcamp: View {
    @State var rating: Int = 3
    
    var body: some View {
        ZStack{
            starView
                .overlay(overlayView.mask(alignment: .leading, {
                    starView
                }))
                // mask就是将其裁剪成里面view的模样
        }
    }
    
    private var overlayView: some View{
        GeometryReader{geometry in
            Rectangle()
                .foregroundStyle(.yellow)
                .frame(width: geometry.size.width * CGFloat(rating) / 5)
        }
        .allowsHitTesting(false) // 这样用户才可以点击到下面的元素
    }
    
    private var starView: some View{
        HStack{
            ForEach(1..<6){index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(index <= rating ? .yellow : .gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
}

#Preview {
    MaskBootcamp()
}
