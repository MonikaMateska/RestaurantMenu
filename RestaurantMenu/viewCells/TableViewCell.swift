//
//  TableViewCell.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 5/8/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var itemImage: UIImageView!
    
    func setItem(from item: TableCell) {
        itemImage.image = UIImage.init(data: item.imageData ?? Data()) 
        title.text = item.title
        descriptionLabel.text = item.description
    }
}
