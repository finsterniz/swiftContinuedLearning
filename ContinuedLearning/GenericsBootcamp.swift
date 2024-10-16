//
//  GenericsBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 13.10.24.
//

import SwiftUI

struct StringModel{
    let info: String?
    
    func removeInfo()->StringModel{
        StringModel(info: nil)
    }
}

// same as above, but generic
// if <T: protocl>, it means T should fullfill some protocol
struct GenericsModel<T>{
    let info: T?
    
    func removeInfo()->GenericsModel{
        GenericsModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject{
    @Published var genericStrModel = GenericsModel(info: "Hello World")
    @Published var genericBoolModel = GenericsModel(info: true)
    
    func removeData(){
        genericStrModel = genericStrModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericsBootcamp: View {
    @StateObject private var vm = GenericsViewModel()

    var body: some View {
        VStack {
            Text(vm.genericStrModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

struct GenericsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootcamp()
    }
}
