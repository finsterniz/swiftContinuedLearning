//
//  HashableBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 16.08.24.
//

import SwiftUI

struct MyCustomModel: Hashable{
    let title: String
    let subtitle: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subtitle) // 使用title和subtitle来生成hash码
    }
}

struct HashableBootcamp: View {

    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE", subtitle: "1"),
        MyCustomModel(title: "TWO", subtitle: "2"),
        MyCustomModel(title: "THREE", subtitle: "3"),
        MyCustomModel(title: "FOUR", subtitle: "4"),
        MyCustomModel(title: "FIVE", subtitle: "5"),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // 只有满足hashable, 才可以将其
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
