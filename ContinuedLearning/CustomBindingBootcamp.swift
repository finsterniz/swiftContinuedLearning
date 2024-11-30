//
//  CustomBindingBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 28.11.24.
//

import SwiftUI

extension Binding where Value == Bool{
    init<T>(value: Binding<T?>){
        self.init {
            // if String? is not nil, then return true
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue{
                // when newValue is false, then set the String? to nil
                value.wrappedValue = nil
            }
        }

    }
}

struct CustomBindingBootcamp: View {
    
    @State var title: String = "Start"
    
    @State var errorTitle: String? = nil
//    @State private var showError: Bool = false
    
    var body: some View {
        VStack{
            Text(title)
            
            ChildView1(title: $title)
            ChildView2(title: $title) {newTitle in
                title = newTitle
            }
            
    //        ChildView3(newTitle: $title)
            
            ChildView3(newTitle: Binding(get: {
                return title
            }, set: { newValue in
                title = newValue
            }))
            
            Button(action: {
                errorTitle = "New Error"
            }, label: {
                Text("Click me")
            })
        }
//        .alert(errorTitle ?? "Error", isPresented: Binding(get: {
//            errorTitle != nil
//        }, set: { newValue in
//            errorTitle = newValue ? "Unknown" : nil
//        })) {
//            Button(action: {
//                
//            }, label: {
//                Text("OK")
//            })
//        }
        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
            Button(action: {

            }, label: {
                Text("OK")
            })
        }
        
    }
}

struct ChildView1: View {
    
    @Binding var title: String
    
    var body: some View {
        Text(title)
    }
}

struct ChildView2: View {
    
    @Binding var title: String
    let setTitle: (String)->()
    
    var body: some View {
        Text(title)
//            .onAppear{
//                setTitle("New Title 2")
//            }
    }
}

struct ChildView3: View {
    
    var newTitle: Binding<String>
    
    var body: some View {
        Text("")
            .onAppear(perform: {
                newTitle.wrappedValue = "New Title 3"
            })
    }
}

#Preview {
    CustomBindingBootcamp()
}
