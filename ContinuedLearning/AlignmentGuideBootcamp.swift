//
//  AlignmentGuideBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 14.09.24.
//

import SwiftUI

struct AlignmentGuideBootcamp: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, world")
                .background(Color.blue)
                .alignmentGuide(.leading, computeValue: { dimension in
                    // push 20 pixel in leading
                    // return 20
                    
                    // use the width of VStack to push in leading
                    return dimension.width
                })
            
            Text("This is some other text")
                .background(Color.red)
        }
        .background(Color.orange)
    }
}

fileprivate struct AlignmentChildView: View {
    var body: some View {
        VStack(alignment: .leading){
            row(title: "Row 1", showIcon: false)
            row(title: "Row 2", showIcon: true)
            row(title: "Row 3", showIcon: false)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(40)
    }
    
    private func row(title: String, showIcon: Bool) -> some View{
        HStack(spacing: 10) {
            if showIcon{
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
            
            Spacer()
        }
        .alignmentGuide(.leading, computeValue: { dimension in
            return showIcon ? 40 : 0
        })
    }
}

#Preview {
    AlignmentChildView()
}
