//
//  AnyTransitionBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 01.10.24.
//

import SwiftUI

struct RotateViewModifier: ViewModifier{
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

extension AnyTransition{
    static var rotation: AnyTransition{
        // if transite, rotate 180 degrees
        return AnyTransition.modifier(
        active: RotateViewModifier(rotation: 180),
          identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotation(degree: Double)->AnyTransition{
        // if transite, rotate 180 degrees
        return AnyTransition.modifier(
        active: RotateViewModifier(rotation: degree),
          identity: RotateViewModifier(rotation: 0))
    }
}

struct AnyTransitionBootcamp: View {
    
    @State var showRectangle: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            
            if showRectangle{
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 200, height: 200)
//                    .transition(AnyTransition.scale.animation(.easeInOut)) // transition of scale effect
//                    .transition(.rotation)
//                    .transition(.rotation(degree: 720))
                    .transition(.asymmetric(insertion: .rotation, removal: .move(edge: .leading)))
                
            }
            
            Spacer()
            
            Button("tap me"){
                withAnimation(.easeInOut(duration: 2)) {
                    showRectangle.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    AnyTransitionBootcamp()
}
