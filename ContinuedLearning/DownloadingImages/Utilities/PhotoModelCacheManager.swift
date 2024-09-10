//
//  PhotoModelCacheManager.swift
//  ContinuedLearning
//
//  Created by a on 10.09.24.
//

import Foundation
import SwiftUI

// A manager to add photo cache by using memory
class PhotoModelCacheManager{
    static let instance = PhotoModelCacheManager()
    
    private init(){ }
    
    // 创建cache
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    // add an image in cache by using key
    func add(key: String, value: UIImage){
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    // by using key to get cache
    func get(key: String)-> UIImage?{
        return photoCache.object(forKey: key as NSString)
    }
    
    
    
}
