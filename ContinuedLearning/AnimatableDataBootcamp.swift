//
//  AnimatableDataBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 09.10.24.
//

import SwiftUI

struct AnimatableDataBootcamp: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                Pacman(offsetAmount: animate ? 20 : 0)
                                .frame(width: 200, height: 200)
                
                RectangleWithSingleCornerAnimation(cornerRadius: animate ? 60 : 0)
                                .frame(width: 200, height: 200)
            }
        }
        .onAppear{
            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(), {
                animate.toggle()
            })
        }
    }
}

struct RectangleWithSingleCornerAnimation: Shape{
    
    var cornerRadius: CGFloat
    
    // 让view跟着这个Data来改变
    var animatableData: CGFloat{
        get{ cornerRadius }
        set{ cornerRadius = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct Pacman: Shape{
    var offsetAmount: Double
    
    var animatableData: Double{
        get{ offsetAmount }
        set{ offsetAmount = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2,
                startAngle: Angle(degrees: offsetAmount),
                endAngle: Angle(degrees: 360 - offsetAmount),
                clockwise: false
            )
        }
    }
}

#Preview {
    AnimatableDataBootcamp()
}
