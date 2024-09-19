//
//  KeypathsBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 18.09.24.
//

import SwiftUI

struct MyDataModel: Identifiable{
    var id: String = UUID().uuidString
    var title: String
    var count: Int
    var date: Date
}

struct MovieTitle{
    var firstTitle: String
    var secondTitle: String
}

//extension Array where Element == MyDataModel{
//    func customSorted()->[MyDataModel]{
//        self.sorted { item1, item2 in
//            return item1.count < item2.count
//        }
//    }
//}

extension Array{
    //    func customSorted()->[MyDataModel]{
    //        self.sorted { item1, item2 in
    //            return item1.count < item2.count
    //        }
    //    }
    
    // 使用MyDataModel中符合Int协议的keypath
    //    func customSorted(keyPath: KeyPath<MyDataModel, Int>)->[MyDataModel]{
    //        self.sorted { item1, item2 in
    //            return item1[keyPath: keyPath] < item2[keyPath: keyPath]
    //        }
    //    }
    
    // 使用MyDataModel中符合Comparable协议的keypath, 这样Int和Date都可以用
    //    func customSorted<T: Comparable>(keyPath: KeyPath<MyDataModel, T>)->[MyDataModel]{
    //        self.sorted { item1, item2 in
    //            return item1[keyPath: keyPath] < item2[keyPath: keyPath]
    //        }
    //    }
    
    // 使用MyDataModel中符合Comparable协议的keypath, 这样Int和Date都可以用
    func sortedByKeypath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true)->[Element]{
        self.sorted { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            return ascending ? (value1 < value2) : (value2 < value1)
        }
    }
    
    // directly sort the origin array
    mutating func sortByKeypath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true){
        self.sort{ item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            return ascending ? (value1 < value2) : (value2 < value1)
        }
    }
}

struct KeypathsBootcamp: View {
    
    @State private var screenTitle: String = ""
    @State private var dataArray: [MyDataModel] = []
    
    var body: some View {
        List{
            ForEach(dataArray) { item in
                VStack(alignment: .leading){
                    Text(item.id)
                    Text(item.title)
                    Text("\(item.count)")
                    Text(item.date.description)
                }
            }
            
        }
        .onAppear{
            var array = [
                MyDataModel(title: "One", count: 1, date: .now),
                MyDataModel(title: "Two", count: 2, date: .distantPast),
                MyDataModel(title: "Three", count: 3, date: .distantFuture),
            ]
//                .customSorted(keyPath: \.count)
//                .customSorted(keyPath: \.date)
//                .sortedByKeypath(\.date, ascending: false)
                
            array.sortByKeypath(\.id, ascending: true)
            
            dataArray = array
        }
    }
}

#Preview {
    KeypathsBootcamp()
}
