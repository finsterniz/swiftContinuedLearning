//
//  DownloadingImagesViewModel.swift
//  ContinuedLearning
//
//  Created by a on 06.09.24.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    
    let dataService = PhotoModelDataService.instance
    
    var cancellables: Set<AnyCancellable> = []
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$photoModel
            .sink { [weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
            }.store(in: &cancellables)
    }
}
