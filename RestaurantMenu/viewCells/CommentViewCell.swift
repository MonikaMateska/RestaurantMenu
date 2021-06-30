//
//  CommentViewCell.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 10.6.21.
//

import UIKit

class CommentViewCell: UITableViewCell {
    
    @IBOutlet weak var imageItem: UIImageView!
    
    @IBOutlet weak var commentDateLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    func setItem(from item: CommentCell) {
        imageItem.image = UIImage.init(data: item.imageData ?? Data())
        commentDateLabel.text = item.date
        commentLabel.text = item.comment
    }
}
