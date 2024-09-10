//
//  PhotoModelFileManager.swift
//  ContinuedLearning
//
//  Created by a on 10.09.24.
//

import Foundation
import SwiftUI

// A manager to add photo cache to cache directory
class PhotoModelFileManager{
    static let instance = PhotoModelFileManager()
    
    let folderName = "downloaded_photos"
    
    private init(){
        createFolderIfNeeded()
    }
    
    
    private func createFolderIfNeeded(){
        guard let url = getFolderPath() else { return }
        if !FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            }catch{
                print("Error creating folder: \(error)")
            }
        }
    }
    
    private func getFolderPath()->URL?{
        return FileManager
            .default
        // in cachesdirectory, the file would not be remove when relaunch the app.
        // but if ROM not enough, system might clean this up.
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    // .../downloaded_photos/
    // .../downloaded_photos/image_name.png
    private func getImagePath(key: String)->URL? {
        guard let folder = getFolderPath() else{
            return nil
        }
        return folder.appendingPathComponent(key + ".png")
    }
    
    // add an image in cache directory by using key(id)
    func add(key: String, value: UIImage){
        guard let data = value.pngData(),
              let url = getImagePath(key: key) else { return }
        
        do{
            try data.write(to: url)
        }catch{
            print("Error saving to file manager: \(error)")
        }
    }
    
    // by using key to get cache from cache directory
    func get(key: String)-> UIImage?{
        guard let url = getImagePath(key: key),
              // percentEncoded: true：表示路径中包含特殊字符，系统会将它们编码为百分号转义序列（如空格变成 %20）。
              // percentEncoded: false：表示路径不包含特殊字符，适合标准的路径处理。
              FileManager.default.fileExists(atPath: url.path(percentEncoded: false))
        else { return nil }
        
        return UIImage(contentsOfFile: url.path(percentEncoded: false))
    }
}
