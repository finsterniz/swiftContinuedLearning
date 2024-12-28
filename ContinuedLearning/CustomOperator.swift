//
//  CustomOperator.swift
//  ContinuedLearning
//
//  Created by a on 28.12.24.
//

import SwiftUI

struct CustomOperator: View {
    @State var value: Double = 3
    var body: some View {
        Text("\(value)")
            .onAppear{
//                value = 5 +/ 2
//                value = 200 ++/ 5
                let someValue: Int = 5
                value = someValue => Double.self
            }
    }
}

infix operator +/
infix operator ++/
infix operator =>


extension Float{
    static public func +/(lhs: Self, rhs: Self)->Self{
        return (lhs + rhs) / 2
    }
    
    static public func ++/(lhs: Self, rhs: Self)->Self{
        return (lhs + lhs) / rhs
    }
}

protocol InitFromBinaryFloatingPoint{
    init<Source>(_ value: Source) where Source : BinaryInteger
}

extension Double: InitFromBinaryFloatingPoint{
    
}

extension BinaryInteger{
    static func => <T: InitFromBinaryFloatingPoint>(value: Self, newType: T.Type)->T{
        return T(value)
    }
}


#Preview {
    CustomOperator()
}
