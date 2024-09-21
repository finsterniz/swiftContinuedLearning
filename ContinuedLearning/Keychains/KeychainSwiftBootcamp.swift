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
struct KeychainStorage: DynamicProperty{
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

struct KeychainSwiftBootcamp: View {
    
//    @State private var userPassword: String = ""
//    @Environment(\.keychain) var keychain
    @KeychainStorage("user_password3") var userPassword: String = "ha"
    
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
    }
}

#Preview {
    KeychainSwiftBootcamp()
}
