//
//  ViewController.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 5/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var beverageButton: UIButton!
    
    private var selectedItemType: ItemType = .food
    private var storage = UserDefaultsStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        foodButton.backgroundColor = #colorLiteral(red: 1, green: 0.6675911546, blue: 0, alpha: 0.3760702055)
        beverageButton.backgroundColor = #colorLiteral(red: 1, green: 0.6675911546, blue: 0, alpha: 0.3760702055)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SecondViewController {
            secondVC.itemsType = selectedItemType
            secondVC.storage = storage
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text else {
            return
        }
        
        switch buttonText {
        case "Food":
            foodButton.backgroundColor = #colorLiteral(red: 0.7640677094, green: 0.5144343376, blue: 0.05251441896, alpha: 0.6118899829)
            selectedItemType = .food
        default:
            beverageButton.backgroundColor = #colorLiteral(red: 0.7640677094, green: 0.5144343376, blue: 0.05251441896, alpha: 0.6118899829)
            selectedItemType = .beverage
        }
    }
    
}

