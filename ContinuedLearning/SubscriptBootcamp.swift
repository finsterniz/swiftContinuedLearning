//
//  SubscriptBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 25.12.24.
//

import SwiftUI

extension Array where Element == String{
    
    // Element 是 Array 的泛型参数，用来表示数组中存储的元素类型。
    // Element is Generic Type for the element in Arr
//    func getItem(atIndex idx: Int)->Element?{
//        for (index, element) in self.enumerated(){
//            if index == idx{
//                return element
//            }
//        }
//        return nil
//    }
    
    subscript(value: String)->String?{
        self.first(where: {$0 == value})
    }
}

struct Customer{
    let name: String
    let adress: String
    
    subscript(value: String)->String?{
        switch value{
        case "name":
            return self.name
        case "adress":
            return self.adress
        default:
            return nil
        }
    }
}

// subscript: 下标
struct SubscriptBootcamp: View {
    @State private var myArray: [String] = ["one", "two", "three"]
    @State private var selectedItem: String? = nil

    var body: some View {
        VStack {
            ForEach(myArray, id: \.self) { string in
                Text(string)
            }

            Text("SELECTED: \(selectedItem ?? "none")")
        }
        .onAppear {
//            selectedItem = myArray.getItem(atIndex: 5)
//            selectedItem = myArray["two"]
            let customer1 = Customer(name: "hao", adress: "Haupt Strasse")
            
            selectedItem = customer1["adress"]
        }
    }
}

#Preview {
    SubscriptBootcamp()
}
