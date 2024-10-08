//
//  CustomCurvesBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 08.10.24.
//

import SwiftUI

struct CustomCurvesBootcamp: View {
    var body: some View {
        
        VStack{
            WaterShape()
                .frame(width: 200, height: 200)
            
            ArcSample()
                .frame(width: 200, height: 200)
                .padding(.bottom, 50)
            
            QuadSample()
                .frame(width: 200, height: 200)
            
            ShapeWithArc()
                .frame(width: 200, height: 200)
                .offset(y: -100)
        }
    }
}


struct ArcSample: Shape{
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY), // 中心点
                radius: rect.height / 2, // 占rect长度的多少
                startAngle: Angle(degrees: -20), // 起始角
                endAngle: Angle(degrees: 40), // 结束角
                clockwise: true // 是否按钟表顺序
            )
        }
    }
}

struct ShapeWithArc: Shape{
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            // mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            // bottom
            //path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
            
            // mid left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}

struct QuadSample: Shape{
    
    func path(in rect: CGRect) -> Path{
        Path{path in
            path.move(to: .zero)
            path.addQuadCurve(
                to: CGPoint(
                    x: rect.midX,
                    y: rect.midY
                ),
                control: CGPoint( // 类似于bezir曲线的控制点位置
                    x: rect.maxX - 50,
                    y: rect.minY - 100
                )
            )
            
        }
    }
}

struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.25)
            )
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.75)
            )
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

#Preview {
    CustomCurvesBootcamp()
}
