//
//  PropertyWrapperBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 14.12.24.
//

import SwiftUI

extension FileManagerProperty{
    static func documentsPath(key: String) -> URL{
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "\(key).txt")
    }
}

@propertyWrapper
struct FileManagerProperty: DynamicProperty{
    @State private var title: String
    let key: String
    
    // 真实值, 保存着它的数值
    var wrappedValue: String{
        get{
            title
        }
        // let the compiler know that this func won't change the struct, but only change state
        nonmutating set{
            setTitle(newValue: newValue)
        }
    }
    
    // 定义这个值可以让我们像 @Binding一样使用它
    // 用$符号来使用它
    // 只有被标记为 @propertyWrapper时候才可以定义
    public var projectedValue: Binding<String> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }
    
    // Swift 规定，当你为属性包装器定义初始化方法时，wrappedValue 是第一个参数，并且在使用时可以省略其标签。
    // 这意味着，编译器会自动将第一个参数视为 wrappedValue，无需显式标注。
    init(wrappedValue: String,_ key: String) {
        self.key = key
        do{
            title = try String(contentsOf: FileManagerProperty.documentsPath(key: key), encoding: .utf8)
            print("SUCCESSFUL READ")
        }catch{
            title = wrappedValue
            print("ERROR READ: \(error)")
        }
    }
    
    func setTitle(newValue: String){
        let uppercased = newValue.uppercased()
        title = uppercased
        save(newValue: uppercased)
    }
    
    func save(newValue: String){
        do{
            // atomically: true -> data will be written to a temporary file
            // atomically: true -> 数据写入临时文件
            // atomically: false -> data is written to directly to the specified file path
            // atomically: false -> 数据直接写入制定文件路径
            try newValue.write(to: FileManagerProperty.documentsPath(key: key), atomically: false, encoding: .utf8)
            print("SUCCESSFUL SAVED")
        }catch{
            print("ERROR SAVING")
        }
    }
}

struct PropertyWrapperBootcamp: View {
//    @State private var title: String = "Starting title"
//    var fileManagerProperty = FileManagerProperty()
    
    // a @propertyWrapper, which will directly use the wrappedValue
    // 使用 @propertyWrapper, 直接就会使用其wrappedValue
    @FileManagerProperty("newTitle1") var title1 = "Starting title1"
    @FileManagerProperty("newTitle2") var title2 = "Starting title2"
    @FileManagerProperty("newTitle3") var title3 = "Starting title3"
    
    var body: some View {
        VStack(spacing: 40){
            Text(title1).font(.largeTitle)
            Text(title2).font(.largeTitle)
            
            Button(action: {
                title1 = "title 1"
            }, label: {
                Text("Click me 1")
            })
            
            Button(action: {
                title1 = "title 2"
                title2 = "random title"
            }, label: {
                Text("Click me 2")
            })
            
            PropertyWrapperChildView(title: $title3)
        }
    }
}

struct PropertyWrapperChildView: View {
    @Binding var title: String
    var body: some View {
        Text(title)
            .foregroundStyle(.blue)
            .font(.largeTitle)
            .onTapGesture {
                title = "Title has changed"
            }
    }
}

#Preview {
    PropertyWrapperBootcamp()
}
