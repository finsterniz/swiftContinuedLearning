//
//  GenSeturateColor.swift
//  ContinuedLearning
//
//  Created by a on 21.09.24.
//

import SwiftUI

struct GenSeturateColor: View {
    var body: some View {
        ScrollView{
            ForEach(1..<50){_ in
                Rectangle()
                    .fill(Color(hue: Double.random(in: 0...1), saturation: 0.8, brightness: 0.8))
            }
        
            Rectangle()
                .frame(height: 30)
            
//            ForEach(1..<50){i in
//                Rectangle()
//                    .fill(Color(hue: 0.02 * Double(i), saturation: 0.8, brightness: 0.7))
//            }
        }
    }
    
    func randomColorAvoidingGreen() -> Color {
        let hue = Double.random(in: 0...0.3) + (Double.random(in: 0.5...1))
        return Color(hue: hue, saturation: 0.7, brightness: 0.6)
    }
}

#Preview {
    GenSeturateColor()
}
