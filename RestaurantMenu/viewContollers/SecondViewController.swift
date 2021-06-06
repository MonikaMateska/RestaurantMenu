//
//  SecondViewController.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 5/8/21.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var itemsType: ItemType = .food
    var storage: LocalStorage? = nil
    
    private var items = [RestaurantItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = itemsType == .food ? "Food" : "Beverage"
        
        items = RestaurantItem.createItems().filter { $0.type == itemsType }
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! TableViewCell
        cell.setItem(from: item)
        
        return cell
    }
    
    
}
