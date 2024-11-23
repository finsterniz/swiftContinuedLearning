//
//  UIViewRepresentableBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 23.11.24.
//

import SwiftUI

struct UIViewRepresentableBootcamp: View {
    @State var text: String = ""
    
    var body: some View {
        VStack{
            Text(text)
            TextField("Type here...", text: $text)
                .frame(height: 50)
                .background(.gray)
                
            UITextFieldRepresentable(text: $text, placeHolder: "Type here", placeholderColor: .purple)
                .updatePlaceholder("new Placeholder")
                .frame(height: 50)
                .background(.gray)
        }
    }
}

struct UITextFieldRepresentable: UIViewRepresentable{
    
    @Binding var text: String
    var placeHolder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeHolder: String = "Default Placeholder", placeholderColor: UIColor = .red) {
        self._text = text
        self.placeHolder = placeHolder
        self.placeholderColor = placeholderColor
    }
    
    // because UITextfield inherent UIView, such that we can directly return UITextfiled
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    // send data from swiftUI to UIKit
    // func updateUIView(_ uiView: UIViewType, context: Context) {
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField{
        let textfield = UITextField(frame: .zero)
        
        let placeholder = NSAttributedString(
            string: placeHolder,
            attributes: [
                .foregroundColor: placeholderColor
            ]
        )
        
        textfield.attributedPlaceholder = placeholder
        return textfield
    }
    
    func updatePlaceholder(_ text: String) -> UITextFieldRepresentable{
        var viewRepresentable = self
        viewRepresentable.placeHolder = text
        return viewRepresentable
    }
    
    // send data from UIKit to swiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    // only use in this struct, such that we make it inside the struct
    class Coordinator: NSObject, UITextFieldDelegate{
        @Binding var text: String
        
        init(text: Binding<String>){
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable{
    
    // on init, this func will be executed
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    // this func will be called after makeUIView
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}
