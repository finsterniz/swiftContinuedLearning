//
//  MatchedGeometryEffectBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 05.10.24.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    
    @State var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack{
            if !isClicked{
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                // matchedGeometry要放在frame的前面, 否则可能出现奇怪的阴影效果
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            if isClicked{
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffect2: View {
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace var namespace
    var body: some View {
        HStack{
            ForEach(categories, id: \.self) { cat in
                ZStack{
                    if selected == cat{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.3))
                            .matchedGeometryEffect(id: "background", in: namespace)
                    }
                    
                    Text(cat)
                }
                .onTapGesture {
                    withAnimation(.spring) {
                        selected = cat
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 55)
            }
            .padding()
        }
    }
}

#Preview {
    MatchedGeometryEffectBootcamp()
//    MatchedGeometryEffect2()
}
