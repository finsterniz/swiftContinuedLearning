//
//  ButtonStyleBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 26.09.24.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle{
    
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
        
    }
}

//
extension View{
    func withPressableStyle(scaledAmount: CGFloat = 0.9)->some View{
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Click me")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
        }
//        .buttonStyle(PressableButtonStyle())
        .withPressableStyle(scaledAmount: 0.9)
        .padding(40)

    }
}

#Preview {
    ButtonStyleBootcamp()
}
