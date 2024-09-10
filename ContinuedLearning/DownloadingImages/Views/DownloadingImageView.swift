//
//  DownloadingImageView.swift
//  ContinuedLearning
//
//  Created by a on 06.09.24.
//

import SwiftUI

struct DownloadingImageView: View {
    
//    @State var isLoading: Bool = true
    @StateObject var loader: ImageLoadingViewModel
    
    init(url: String, key: String){
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack{
            if loader.isLoading{
                ProgressView()
            }else if let image = loader.image{
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "some key")
        .frame(width: 75, height: 75)
        .padding()
//        .background(.blue)
}
