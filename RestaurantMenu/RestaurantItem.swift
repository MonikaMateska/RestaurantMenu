//
//  File.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 5/8/21.
//

import Foundation
import UIKit

class RestaurantItem {
    
    var image: UIImage
    var title: String
    var description: String
    
    init(image: UIImage,
         title: String,
         description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
    
}
