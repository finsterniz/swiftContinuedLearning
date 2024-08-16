//
//  ScrollViewReaderBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 13.08.24.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                Button("CLICK HERE TO GO TO #30") {
                    withAnimation(.spring()) {
                        proxy.scrollTo(30, anchor: .center)
                    }
                }
                
                ForEach(0..<50) { index in
                    Text("This is item #\(index)")
                        .font(.headline)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                        .id(index)
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
