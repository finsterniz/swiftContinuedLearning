//
//  DownloadedImagesRow.swift
//  ContinuedLearning
//
//  Created by a on 06.09.24.
//

import SwiftUI

struct DownloadedImagesRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack{
            DownloadingImageView(url: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading){
                Text(model.title)
                    .font(.headline)
                
                Text(model.url)
                    .foregroundStyle(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    DownloadedImagesRow(model: PhotoModel(albumId: 1, id: 2, title: "ha", url: "https://via.placeholder.com/150/771796", thumbnailUrl: "https://via.placeholder.com/150/771796"))
        .padding()
        .background(.blue)
}
