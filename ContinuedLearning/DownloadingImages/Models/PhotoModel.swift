//
//  PhotoModel.swift
//  ContinuedLearning
//
//  Created by a on 06.09.24.
//

import Foundation

struct PhotoModel: Identifiable, Codable{
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
