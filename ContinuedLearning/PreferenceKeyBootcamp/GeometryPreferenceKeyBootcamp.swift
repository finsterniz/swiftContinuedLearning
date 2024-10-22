//
//  GeometryPreferenceKeyBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 19.10.24.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    
    @State var rectangleSize: CGSize = .zero
    
    var body: some View {
        HStack{
            Text("Hello, world!")
                .frame(width: rectangleSize.width, height: rectangleSize.height)
                .background(.blue)
                
        }
        .frame(maxHeight: .infinity)
        
        HStack{
            Rectangle()
            GeometryReader(content: { geometry in
                Rectangle()
                    .updateRectangleGeoSize(geometry.size)
            })
            Rectangle()
        }
        .frame(height: 55)
        .onPreferenceChange(RectangleGeometryPreference.self, perform: { value in
            self.rectangleSize = value
        })
    }
}

#Preview {
    GeometryPreferenceKeyBootcamp()
}

extension View{
    func updateRectangleGeoSize(_ size: CGSize)->some View{
        preference(key: RectangleGeometryPreference.self, value: size)
    }
}

struct RectangleGeometryPreference: PreferenceKey{
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
