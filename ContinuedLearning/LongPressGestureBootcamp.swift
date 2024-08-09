//
//  LongPressGestureBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 08.08.24.
//

import Foundation
import SwiftUI

struct LongPressGestureBootcamp: View{
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack{
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .ignoresSafeArea()
                .frame(maxWidth: isComplete ? .infinity : 10 )
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack{
                
                Text("Click Here")
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                    .onLongPressGesture(
                        minimumDuration: 1.0,
                        maximumDistance: 50) { onPressing in
                            if onPressing{
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    isComplete = true
                                }
                            }else{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    if !isSuccess{
                                        withAnimation {
                                            isComplete = false
                                        }
                                    }
                                }
                            }
                        } perform: {
                            withAnimation(.easeInOut){
                                isSuccess = true
                            }
                        }

                Text("Reset")
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                    .onTapGesture {
                        isSuccess = false
                        isComplete = false
                    }
            }
            
//            Text(isComplete ? "COMPLETED" : "NOT COMPLETE")
//                .padding()
//                .padding(.horizontal)
//                .background(isComplete ? Color.green : Color.gray)
//                .cornerRadius(10)
//                .onLongPressGesture(
//                    minimumDuration: 2, // after 2 seconds to take effect
//                    maximumDistance: 50 // when user is pressing, the move distance smaller than 50 will take effect
//                ) {
//                    isComplete.toggle()
//                }
        }
    }
}

#Preview {
    LongPressGestureBootcamp()
}
