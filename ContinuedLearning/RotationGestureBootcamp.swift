//
//  RotationGestureBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 10.08.24.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    @State var rotationAngle: Angle = .zero
    
    var body: some View {
        Text("Hello, World!")
            .padding(50)
            .background(Color.blue)
            .cornerRadius(5)
            .rotationEffect(rotationAngle)
            .gesture(
                RotationGesture()
                    .onChanged({ rotateAngle in
                        self.rotationAngle = rotateAngle
                    })
                    .onEnded({ rotateAngle in
                        withAnimation {
                            rotationAngle = Angle(degrees: 0)
                        }
                    })
            )
    }
}

#Preview {
    RotationGestureBootcamp()
}
