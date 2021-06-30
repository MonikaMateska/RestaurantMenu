//
//  UserStoryController.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 6.6.21.
//

import Foundation
import UIKit
import Combine

class UserStoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewMemoryButton: UIButton!
    
    private struct Constants {
        static let userStoryCommentsKey = "userStoryComments"
    }
    
    var comments = [CommentCell]()
    var storage: LocalStorage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Your story with us"
        tableView.delegate = self
        tableView.dataSource = self
        addNewMemoryButton.layer.cornerRadius = 5
        loadComments()
    }
    
    @IBAction func didTapCaptureImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func storeComment(_ comment: CommentCell) {
        comments.insert(comment, at: 0)
        saveComments()
    }
    
    //MARK: - private
    
    private func saveComments() {
        if let data = try? JSONEncoder().encode(comments) {
            storage?.save(value: data, forKey: Constants.userStoryCommentsKey)
        }
        tableView.reloadData()
    }
    
    private func loadComments() {
        if let data = storage?.value(forKey: Constants.userStoryCommentsKey) as? Data,
            let storedComments = try? JSONDecoder().decode([CommentCell].self,
                                                   from: data) {
            comments = storedComments
        }
    }
}

extension UserStoryViewController: UIImagePickerControllerDelegate,
                               UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        picker.dismiss(animated: true) {
            self.navigateToPhotoViewController(photo: image)
            return
        }
        
    }
    
    func navigateToPhotoViewController(photo: UIImage) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let photoViewController = storyBoard.instantiateViewController(withIdentifier: "photoViewController") as! PhotoViewController
        photoViewController.photo = photo
        self.present(photoViewController, animated: true, completion: nil)
    }
}

extension UserStoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! CommentViewCell
        cell.setItem(from: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            comments.remove(at: indexPath.row)
            saveComments()
        }
    }
}
