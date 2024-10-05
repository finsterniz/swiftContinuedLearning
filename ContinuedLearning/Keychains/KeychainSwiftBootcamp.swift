//
//  KeychainSwiftBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 21.09.24.
//

import SwiftUI
import KeychainSwift

final class KeychainManager{
    private let keychain: KeychainSwift
    
    init() {
        let keychain = KeychainSwift()
        keychain.synchronizable = true // 允许设备间同步
        self.keychain = keychain
    }
    
    func set(_ value: String, key: String){
        keychain.set(value, forKey: key)
    }
    
    func get(key: String)->String?{
        keychain.get(key)
    }
    
    func getData(key: String)->Data?{
        guard let dataString = keychain.get(key) else { return nil}
        return Data(base64Encoded: dataString)
    }
}

// EnvironmentKey protocol: must have a defaultValue
struct KeychainManagerKey: EnvironmentKey{
    // define the default value for environemnt key
    static let defaultValue: KeychainManager = KeychainManager()
}

extension EnvironmentValues{
    var keychain: KeychainManager{
        get{
            self[KeychainManagerKey.self]
        }
        set{
            self[KeychainManagerKey.self] = newValue
        }
    }
}

@propertyWrapper
struct KeychainStorage1: DynamicProperty{
    @State private var newValue: String
    let key: String
    let keychain: KeychainManager
    
    var wrappedValue: String{
        get{
            newValue
        }
        nonmutating set{
            save(newValue: newValue)
        }
    }
    
    var projectValue: Binding<String>{
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }
    
    // 属性包装器必须有wrappedValue
    init(wrappedValue: String, _ key: String) {
//        self.newValue = newValue
        self.key = key
        self.keychain = KeychainManager()
        
        self._newValue = State(initialValue: keychain.get(key: key) ?? wrappedValue)
        print("Sucessful read")
    }
    
    func save(newValue: String){
        keychain.set(newValue, key: key)
        self.newValue = newValue
        print("Sucessful Saved")
    }
}

@propertyWrapper
struct KeychainStorage<T: Codable>: DynamicProperty{
    @State var value: T
    let key: String
    let keychain: KeychainManager
    
    var wrappedValue: T{
        get{
            value
        }
        nonmutating set{
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<T>{
        Binding(get: {
            self.wrappedValue
        }, set: {
            self.wrappedValue = $0
        })
    }
    
    init(wrappedValue: T, _ key: String){
        self.key = key
        self.keychain = KeychainManager()
        if let data = keychain.getData(key: key),
           let decoded = try? JSONDecoder().decode(T.self, from: data){
            self._value = State(initialValue: decoded)
        }else{
            self._value = State(initialValue: wrappedValue)
        }
    }
    
    private func save(newValue: T){
        if let data = try? JSONEncoder().encode(newValue){
            keychain.set(data.base64EncodedString(), key: key)
            self.value = newValue
            print("Successful saved")
        }
    }
}

struct KeychainSwiftBootcamp: View {
    
//    @State private var userPassword: String = ""
//    @Environment(\.keychain) var keychain
//    @KeychainStorage1("user_password3") var userPassword: String = "ha"
    @KeychainStorage("user_password3") var userPassword: String = "ha"
    @KeychainStorage("user_IsVIP1") var userIsVIP: Bool = false
    
    var body: some View {
        Button(action: {
//            let password = "abc"
//            keychain.set(password, key: "newPassword")
            userPassword = "abc1"
        }, label: {
            Text(userPassword.isEmpty ? "no password": userPassword)
        })
//        .onAppear(perform: {
//            userPassword = keychain.get(key: "newPassword") ?? ""
//        })
        
        Button(action: {
//            let password = "abc"
//            keychain.set(password, key: "newPassword")
            userIsVIP.toggle()
        }, label: {
            Text(userIsVIP ? "VIP": "Standard")
        })
    }
}

#Preview {
    KeychainSwiftBootcamp()
}
