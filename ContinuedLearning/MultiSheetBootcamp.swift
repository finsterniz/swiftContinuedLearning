//
//  MultiSheetBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 14.08.24.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct MultipleSheetsBootcamp: View {
    @State var selectedModel: RandomModel? = nil

    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) {
                // 在dismiss的时候执行的东西
            } content: { model in
                NextScreen(selectedModel: model)
            }
        }
    }
}

struct NextScreen: View {
    let selectedModel: RandomModel

    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsBootcamp()
}
