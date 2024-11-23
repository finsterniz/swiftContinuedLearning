//
//  TabBarItem.swift
//  ContinuedLearning
//
//  Created by a on 23.10.24.
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable{
//    let iconName: String
//    let title: String
//    let color: Color 
//}


enum TabBarItem: Hashable{
    case home, favorites, profile
    
    var iconName: String{
        switch self{
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        case .home:
            return "house"
        }
    }
    
    var title: String{
        switch self{
        case .favorites:
            return "Favorites"
        case .profile:
            return "Profile"
        case .home:
            return "Home"
        }
    }
    
    var color: Color{
        switch self{
        case .favorites:
            return .blue
        case .profile:
            return .green
        case .home:
            return .red
        }
    }
}
