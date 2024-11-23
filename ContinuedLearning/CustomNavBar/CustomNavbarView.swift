//
//  CustomNavbarView.swift
//  ContinuedLearning
//
//  Created by a on 12.11.24.
//

import SwiftUI

struct CustomNavbarView: View {
    
    @State private var showBackButton: Bool = true
    @State private var title: String = "Title"
    @State private var subtitle: String? = "Subtitle"
    
    var body: some View {
        HStack{
            if showBackButton{
                backButton
            }
            Spacer()
            titleSection
            Spacer()
            if showBackButton{
                backButton
                    .opacity(0)
            }
        }
        .padding()
        .accentColor(.white)
        .foregroundStyle(.white)
        .font(.headline)
        .background(Color.blue)
    }
}

#Preview {
    VStack{
        CustomNavbarView()
        
        Spacer()
    }
}

extension CustomNavbarView{
    private var backButton: some View{
        Button(action: {
            
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var titleSection: some View{
        VStack(spacing: 4){
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            
            if let subtitle = subtitle{
                Text(subtitle)
            }
        }
    }
}
