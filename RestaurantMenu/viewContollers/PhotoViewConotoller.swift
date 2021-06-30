//
//  File.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 9.6.21.
//

import Foundation
import UIKit
import Combine

class PhotoViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var commentTextField: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    public var photo: UIImage? = nil
    private var activeField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextField.delegate = self
        photoView.image = photo
        photoView.layer.cornerRadius = 5
        photoView.clipsToBounds = true
        doneButton.layer.cornerRadius = 5
        commentTextField.clipsToBounds = true
        commentTextField.layer.cornerRadius = 5
        commentTextField.setNeedsFocusUpdate()
        commentTextField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        if let navController = presentingViewController as? UINavigationController {
            let presenter = navController.topViewController as! UserStoryViewController
            let writtenAt = Date().toString()
            let comment = CommentCell(imageData: photo?.pngData() ?? #imageLiteral(resourceName: "winePlaceholder").pngData(),
                                    date: writtenAt,
                                    comment: commentTextField.text ?? "")
            presenter.storeComment(comment)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tapDone(sender: Any) {
            self.view.endEditing(true)
    }   
    
}

extension PhotoViewController {
    
    func textFieldShouldReturn(_ textField: UITextViewDelegate) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
