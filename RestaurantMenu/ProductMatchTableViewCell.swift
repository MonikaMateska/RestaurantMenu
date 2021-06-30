//
//  ProductMatchTableViewCell.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 3.6.21.
//

import UIKit

class ProductMatchTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    var productUrl = ""
    
    func setItem(from item: ProductDisplayModel) {
        productImage.image = item.image
        title.text = item.title
        price.text = item.price
        productDescription.text = item.description
        productUrl = item.link
        
    }
}
