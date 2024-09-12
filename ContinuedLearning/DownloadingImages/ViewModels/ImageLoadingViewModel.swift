//
//  ImageLoadingViewModel.swift
//  ContinuedLearning
//
//  Created by a on 06.09.24.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject{
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = true
    var cancellables: Set<AnyCancellable> = []
    let urlString: String
//     let manager = PhotoModelCacheManager.instance // use memory
    let manager = PhotoModelFileManager.instance // use ROM
    let imageKey: String
    
    init(url: String, key: String){
        urlString = url
        imageKey = key
        getImage()
    }
    
    // first look for it in cache, if not exist, then download it
    func getImage(){
        if let savedImage = manager.get(key: imageKey){
            image = savedImage
            isLoading = false
            print("Getting saved image")
        }else{
            print("Downloading Image Now!")
            downloadImage()
        }
    }
    
    func downloadImage(){
        guard let url = URL(string: urlString) else {
            isLoading = false
            print("Error downloading image")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .map { (data, response) -> UIImage? in
//                return UIImage(data: data)
//            }
            .map({UIImage(data: $0.data)})
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                switch completion{
                case .finished:
                    self?.isLoading = false
                    print("Image loaded")
                case .failure(let error):
                    self?.isLoading = false
                    print("Error fetching image \(error)")
                }
            } receiveValue: {[weak self] receivedImage in
                guard 
                    let self = self,
                    let image = receivedImage else{ return }
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }.store(in: &cancellables)
    }
}
