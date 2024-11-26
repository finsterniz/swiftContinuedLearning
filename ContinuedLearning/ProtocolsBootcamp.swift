//
//  ProtocolsBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 24.11.24.
//

import SwiftUI

struct DefaultColorTheme : ColorThemeProtocol{
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme : ColorThemeProtocol{
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

// protocols have to declare, which attribute it should have(get/set)
protocol ColorThemeProtocol{
    var primary: Color{ get }
    var secondary: Color{ get }
    var tertiary: Color{ get }
}

protocol ButtonTextProtocol{
    var buttonName:String { set get }
}

protocol ButtonPressedProtocol{
    func buttonPressed()
}

// confirm to both protocol, like Codable
// inherent of protocol
protocol ButtonProtocol: ButtonTextProtocol, ButtonPressedProtocol{
    
}

class AlternativeDataSource: ButtonProtocol{
    var buttonName: String = "Protocols are awesome"
    
    func buttonPressed() {
        print("Button Pressed")
    }
}

struct ProtocolsBootcamp: View {
    
    let colorTheme: ColorThemeProtocol
    let button: AlternativeDataSource
    
    var body: some View {
        ZStack{
            colorTheme.tertiary.ignoresSafeArea()
            
            Text(button.buttonName)
                .font(.headline)
                .foregroundStyle(colorTheme.primary)
                .padding(20)
                .background(colorTheme.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    button.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(colorTheme: AlternativeColorTheme(), button: AlternativeDataSource())
}
