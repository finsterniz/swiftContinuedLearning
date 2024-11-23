//
//  AppNavbarView.swift
//  ContinuedLearning
//
//  Created by a on 12.11.24.
//

import SwiftUI

struct AppNavbarView: View {
    var body: some View {
        CustomNavView{
            ZStack{
                Color.orange.ignoresSafeArea()
                
                NavigationLink {
                    Text("Destination")
                } label: {
                    Text("Navigate")
                }
            }
        }
    }
}

extension AppNavbarView{
    private var defaultNavView: some View{
        NavigationView(content: {
            ZStack(content: {
                Color.green.ignoresSafeArea()
                
                NavigationLink(destination:
                    Text("Destination")
                        .navigationTitle("Title2")
                        .navigationBarBackButtonHidden(false)
                ) { Text("Navigate") }
            })
        })
    }
}

#Preview {
    AppNavbarView()
}
