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

struct KeychainSwiftBootcamp: View {
    
    @State private var userPassword: String = ""
    @Environment(\.keychain) var keychain
    
    var body: some View {
        Button(action: {
            let password = "abc"
            keychain.set(password, key: "newPassword")
        }, label: {
            Text(userPassword.isEmpty ? "no password": userPassword)
        })
        .onAppear(perform: {
            userPassword = keychain.get(key: "newPassword") ?? ""
        })
    }
}

#Preview {
    KeychainSwiftBootcamp()
}
