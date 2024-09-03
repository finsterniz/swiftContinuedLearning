//
//  CacheBootcamp.swift
//  ContinuedLearning
//
//  Created by a on 03.09.24.
//

import SwiftUI

class CacheManager{
    static let instance = CacheManager() // Singleton
    private init(){  }
    
    // <key, value>
    var imageCache: NSCache<NSString, UIImage> = {
       let cache = NSCache<NSString, UIImage>() // could also use data instead of UIImage
        cache.countLimit = 100 // limit of count
        cache.totalCostLimit = 1024 * 1024 * 100 // limit of memory: 100mb
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String{
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cache!"
    }
    
    func remove(name: String) -> String{
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
    
    func get(name: String) -> UIImage?{
        imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject{
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "1024"
    let manager = CacheManager.instance
    
    init(){
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder(){
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache(){
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache(){
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache(){
        if let image = manager.get(name: imageName){
            cachedImage = image
            infoMessage = "Got image from Cache"
        }else{
            infoMessage = "Image not found in Cache"
        }
    }
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                if let startingImage = vm.startingImage{
                    Image(uiImage: startingImage)
                        .resizable()
                        .scaledToFit() // scaleToFit()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundStyle(.purple)
                
                HStack{
                    Button("Save to cache"){
                        vm.saveToCache()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Delete from cache"){
                        vm.removeFromCache()
                    }
                    .tint(.red)
                    .buttonStyle(.borderedProminent)
                }
                
                Button("Get From Cache"){
                    vm.getFromCache()
                }
                .tint(.green)
                .buttonStyle(.borderedProminent)
                
                if let startingImage = vm.cachedImage{
                    Image(uiImage: startingImage)
                        .resizable()
                        .scaledToFit() // scaleToFit()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    CacheBootcamp()
}
