//
//  PhotoModelDataService.swift
//  ContinuedLearning
//
//  Created by a on 06.09.24.
//

import Foundation
import Combine

class PhotoModelDataService{
    
    static let instance = PhotoModelDataService()
    @Published var photoModel: [PhotoModel] = []
    var cancellables: Set<AnyCancellable> = []

    private init(){
        downloadData()
    }
    
    func downloadData(urlString: String = "https://jsonplaceholder.typicode.com/photos"){
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // subscrib on background thread
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput(output:))
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data \(error)")
                }
            } receiveValue: { [weak self] returnedPhotoModels in
                self?.photoModel = returnedPhotoModels
            }.store(in: &cancellables)

    }
    
    // 检查response是否合法
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 300 else{
                
                throw URLError(.badServerResponse)
        }
        return output.data
    }
}
