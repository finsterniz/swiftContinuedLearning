//
//  PropertyWrapper2Bootcamp.swift
//  ContinuedLearning
//
//  Created by a on 23.12.24.
//

import SwiftUI

@propertyWrapper
struct Capitalized: DynamicProperty{
    @State private var value: String
    
    var wrappedValue: String{
        get{
            value
        }
        nonmutating set{
            value = newValue.capitalized
        }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}

@propertyWrapper
struct Uppercased: DynamicProperty{
    @State private var value: String
    
    var wrappedValue: String{
        get{
            value
        }
        nonmutating set{
            value = newValue.uppercased()
        }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.uppercased()
    }
}

@propertyWrapper
struct FileManagerCodableProperty<T: Codable>: DynamicProperty{
    @State private var value: T?
    let key: String
    
    // 真实值, 保存着它的数值
    var wrappedValue: T?{
        get{
            value
        }
        // let the compiler know that this func won't change the struct, but only change state
        nonmutating set{
//            setTitle(newValue: newValue)
            save(newValue: newValue)
        }
    }
    
    // 定义这个值可以让我们像 @Binding一样使用它
    // 用$符号来使用它
    // 只有被标记为 @propertyWrapper时候才可以定义
    public var projectedValue: Binding<T?> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }
    
    // Swift 规定，当你为属性包装器定义初始化方法时，wrappedValue 是第一个参数，并且在使用时可以省略其标签。
    // 这意味着，编译器会自动将第一个参数视为 wrappedValue，无需显式标注。
    init(wrappedValue: T?,_ key: String) {
        self.key = key
        do{
            let url = FileManagerProperty.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            print("SUCCESSFUL READ")
        }catch{
            _value = State(wrappedValue: wrappedValue)
            print("ERROR READ: \(error)")
        }
    }
    
    func save(newValue: T?){
        do{
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManagerProperty.documentsPath(key: key))
            value = newValue
            print("SUCCESSFUL SAVED")
        }catch{
            print("ERROR SAVING")
        }
    }
}

struct User: Codable{
    let name: String
    let age: Int
    let isPremium: Bool
}

struct PropertyWrapper2Bootcamp: View {
    @Uppercased private var title: String = "Hello World"
    @FileManagerCodableProperty("user_profile") private var userProfile: User? = nil
    
    var body: some View {
        VStack(spacing: 40){
            Button(title){
                title = "new title"
            }
            
//            Button(userProfile?.name ?? "no value"){
//                userProfile = User(name: "NICK", age: 100, isPremium: true)
//            }
            SomeBindingView(userProfile: $userProfile)
        }
        .onAppear(perform: {
            print(NSHomeDirectory())
        })
    }
}

struct SomeBindingView: View {
    @Binding var userProfile: User?
    var body: some View {
        Button(userProfile?.name ?? "no value"){
            userProfile = User(name: "JESSICA", age: 130, isPremium: false)
        }
    }
}

#Preview {
    PropertyWrapper2Bootcamp()
}
