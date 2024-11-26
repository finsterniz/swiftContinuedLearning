//
//  TimelineViewBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 26.11.24.
//

import SwiftUI

struct TimelineViewBootcamp: View {
    @State private var startTime: Date = .now
    @State private var pauseAnimation: Bool = false
    
    var body: some View {
        VStack{
            
            // minimumInterval: every second animation instead of milisecond
            // minimumInterval: 触发的频率
            // pause: if stop the animation
            // pause: 是否停止动画, 但底层的var还是会自己改变
            TimelineView(.animation(minimumInterval: 1.0, paused: pauseAnimation)){context in
//            TimelineView(.animation){context in
                Text("\(context.date.timeIntervalSince1970)")
                
//                let seconds = Calendar.current.component(.second, from: context.date)
                
                let seconds = context.date.timeIntervalSince(startTime)
                
                Text("\(seconds)")
                
                Rectangle()
                    .frame(
                        width: seconds < 10 ? 50 : seconds < 30 ? 200 : 400,
                        height: 100
                    )
                    .animation(.bouncy, value: seconds)
            }
            
            Button(pauseAnimation ? "Play" : "Pause"){
                pauseAnimation.toggle()
            }
            
        }
    }
}

#Preview {
    TimelineViewBootcamp()
}
