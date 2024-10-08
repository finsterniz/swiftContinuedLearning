//
//  CustomShapesBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 06.10.24.
//

import SwiftUI

struct Triangle: Shape{
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // 起始点
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // 第二个点
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

// 钻石图形
struct Diamond: Shape{
    func path(in rect: CGRect) -> Path {
        Path{path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct CustomShapesBootcamp: View {
    var body: some View {
        ZStack{
//            Triangle()
            Diamond()
            
//                // 线条
//                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [20, 10]))
//                // 剪切
//                .trim(from: 0, to: 0.5)
//                // 颜色
//                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    CustomShapesBootcamp()
}
