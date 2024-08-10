//
//  DragGestureBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 10.08.24.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack{
                Text("\(offset.width)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring){
                                self.offset = value.translation
                            }
                        })
                        .onEnded({ value in
                            // 缓和一点, 类似于弹簧的回弹效果
                            withAnimation(.spring) {
    //                            self.offset = CGSize(width: 0, height: 0)
                                self.offset = .zero // 等同于上面的
                            }
                        })
            )
        }
    }
    
    // 当拖拽, 百分比会变大, 结果会变小, 因此会产生缩放效果
    func getScaleAmount() -> CGFloat{
        let max = UIScreen.main.bounds.width / 2 // 屏幕的最大宽度的一半
        let currentAmount = abs(offset.width) // 只考虑水平方向的情况
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5 // 最多缩小到原来的一半
    }
    
    func getRotationAmount() -> Double{
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

#Preview {
    DragGestureBootcamp()
}
