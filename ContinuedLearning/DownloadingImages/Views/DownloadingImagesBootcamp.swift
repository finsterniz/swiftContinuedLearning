//
//  DownloadingImagesBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 06.09.24.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadedImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images!")
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}
