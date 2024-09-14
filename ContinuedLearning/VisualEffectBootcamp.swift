//
//  VisualEffectBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 14.09.24.
//

import SwiftUI

struct VisualEffectBootcamp: View {
    
    @State private var showSpacer: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 30){
                ForEach(0..<100){_ in
                    Rectangle()
                        .frame(width: 300, height: 200)
                        .frame(maxWidth: .infinity)
                        .background(.orange)
                        .visualEffect { content, geometry in
                            content
                                .offset(x: geometry.frame(in: .global).minY * 0.4)
                        }
                }
            }
        }
        
//        VStack{
//            Text("Hello, World!")
//                .padding()
//                .background(.red)
//                .visualEffect { content, geometryProxy in
//                    // geometry reader for the whole screen
//                    content.grayscale(geometryProxy.frame(in: .global).minY < 300 ? 1 : 0)
//                }
//            
//            if showSpacer{
//                Spacer()
//            }
//            
//            // content is the text view, geometry is an geometry reader
//            // but only 4 the local view
//            // when size bigger than 200, then turn this into gray
//            /*
//                .visualEffect { content, geometry in
//                    content
//                        .grayscale(geometry.size.width >= 200 ? 1 : 0)
//                }
//             */
//        }
//        .onTapGesture {
//            showSpacer.toggle()
//        }
//        .animation(.easeInOut, value: showSpacer)
    }
}

#Preview {
    VisualEffectBootcamp()
}
