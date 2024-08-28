//
//  CountdownExample.swift
//  testPlayground1
//
//  Created by a on 28.08.24.
//

import SwiftUI

struct CountdownExample: View {
    
    var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(.blue), Color(.black)]),
                center: .center,
                startRadius: 5,
                endRadius: 500
            )
            .ignoresSafeArea()
            
//            HStack(spacing: 15){
//                Circle()
//                    .frame(width: 50)
//                    .offset(y: count % 3 == 0 ? -20: 0)
//                Circle()
//                    .frame(width: 50)
//                    .offset(y: count % 3 == 1 ? -20: 0)
//                Circle()
//                    .frame(width: 50)
//                    .offset(y: count % 3 == 2 ? -20: 0)
//            }
//            .foregroundStyle(.white)
            
            TabView(selection: $count,
                    content:  {
                Rectangle()
                    .fill(.purple)
                    .tag(0)
                Rectangle()
                    .fill(.red)
                    .tag(1)
                Rectangle()
                    .fill(.blue)
                    .tag(2)
                Rectangle()
                    .fill(.yellow)
                    .tag(3)
                Rectangle()
                    .fill(.orange)
                    .tag(4)
            }).tabViewStyle(.page)
                .frame(height: 300)
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.easeIn(duration: 0.5)) {
                count = (count + 1) % 5
            }
        })
    }
}

#Preview {
    CountdownExample()
}
