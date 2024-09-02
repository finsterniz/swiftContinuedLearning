//
//  FileManagerBootcamp.swift
//  testPlayground1
//
//  Created by a on 02.09.24.
//

import SwiftUI

class LocalFileManager{
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    init(){
        createFolderIfNeeded()
    }
    
    // create a special folder for our fileManager
    func createFolderIfNeeded(){
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path else{
            return
        }
        
        if !FileManager.default.fileExists(atPath: path){
            do{
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Successful creaing folder.")
            }catch{
                print("Error creating folder. \(error)")
            }
        }else{
            print("Folder already exist")
        }
    }
    
    func deleteFolder(){
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path else{
            return
        }
        
        do{
            try FileManager.default.removeItem(atPath: path)
            print("Sucess deleting folder")
        }catch let error{
            print("Error deleting folder. \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String)->String{
        guard let data = image.pngData(),let path = getPathForImage(name: name) else{
            return "Error getting data."
        }
        
        // generated by user, not recreatable
//        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // for cache, which could be recreate
//        guard let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
//            return
//        }
        // temporary files
//        let directory3 = FileManager.default.temporaryDirectory

        
        do{
            try data.write(to: path)
            print(path)
            return "Save successful"
        }catch{
            return "Error saving \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage?{
        guard let path = getPathForImage(name: name)?.path, FileManager.default.fileExists(atPath: path) else{
            print("Error getting path")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String)->String{
        guard let path = getPathForImage(name: name)?.path, FileManager.default.fileExists(atPath: path) else{
            return "Error getting path"
        }
        
        do{
            try FileManager.default.removeItem(atPath: path)
            return "Successful deleted."
        }catch{
            return "Error deleting image. \(error)"
        }
    }
    
    func getPathForImage(name: String)->URL?{
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .appendingPathComponent("\(name).png") else{
            return nil
        }
        
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let imageName: String = "1024"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""
        
    init() {
        getImageFromAssetFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetFolder(){
        image = UIImage(named: imageName)
    }
    
    func saveImage(){
        guard let image = image else { return }
        self.infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func getImageFromFileManager(){
        image = manager.getImage(name: imageName)
    }
    
    func deleteImage(){
        self.infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManagerBootcamp: View {
    @StateObject var vm = FileManagerViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button(action: {
                        vm.saveImage()
                    }, label: {
                        Text("Save to FM")
                            .foregroundStyle(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                    
                    Button(action: {
                        vm.deleteImage()
                    }, label: {
                        Text("Delete from FM")
                            .foregroundStyle(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purple)
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerBootcamp()
}