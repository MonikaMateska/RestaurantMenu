import Foundation
import UIKit

enum ItemType: String {
    case food = "Food"
    case beverage = "Beverage"
}

struct TableCell {
    
    var type: ItemType?
    var imageData: Data?
    var title: String
    var description: String
}

struct CommentCell: Codable {
    
    var imageData: Data?
    var date: String
    var comment: String
}

extension TableCell {
    
    /// Creates list of items
    static func createItems() -> [TableCell] {
        var tempItems = [TableCell]()
        let item1 = TableCell(type: .food, imageData: #imageLiteral(resourceName: "dish1").pngData(), title: "Balsamic Glazed Chicken", description: "So simple but SO good.")
        let item2 = TableCell(type: .food, imageData: #imageLiteral(resourceName: "dish2").pngData(), title: "Chicken Fajitas", description: "You won't be able to resist that sizzle.")
        let item3 = TableCell(type: .food, imageData: #imageLiteral(resourceName: "dish3").pngData(), title: "Cilantro-Lime Chicken", description: "We can't get enough of cilantro and lime.")
        let item4 = TableCell(type: .food, imageData: #imageLiteral(resourceName: "dish4").pngData(), title: "Coq Au Vin", description: "This French dish is an absolute classic.")
        let item5 = TableCell(type: .food, imageData: #imageLiteral(resourceName: "dish6").pngData(), title: "Lemon Asparagus Chicken Pasta", description: "This pasta tastes like spring!")
        let item6 = TableCell(type: .food, imageData: #imageLiteral(resourceName: "dish7").pngData(), title: "Garlicky Lemon Mahi Mahi", description: "Mahi Mahi was made for summer.")
        let item7 = TableCell(type: .food, imageData: #imageLiteral(resourceName: "dish9").pngData(), title: "Skillet Chicken Pot Pie", description: "On repeat all winter.")
        let item8 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink1").pngData(), title: "Sangria Lemonade", description: "It's your two favorite warm-weather drinks in one glass.")
        let item9 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink2").pngData(), title: "Pineapple Dessert", description: "Everything you love about the Disney dessert...plus booze!")
        let item10 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink3").pngData(), title: "Cottontail Margaritas", description: "You're just a sip away from a tropical daydream.")
        let item11 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink4").pngData(), title: "Prosecco Punch", description: "Like a screwdriver but better, thanks to pineapple juice and vanilla vodka.")
        let item12 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink5").pngData(), title: "Sweet Tea Sangria", description: "This Southern-inspired sangria is perfect for Easter porch sipping.")
        let item13 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink6").pngData(), title: "Raspberry Mimosa Floats", description: "Brunch ready.")
        let item14 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink7").pngData(), title: "Easter Champagne", description: "Cheers to the end of Lent!")
        let item15 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink8").pngData(), title: "Cherry Sazerac", description: "This gem is a classic for a reason.")
        let item16 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink9").pngData(), title: "Orange Creamsicle Mimosas", description: "Together, they taste just like a Creamsicle.")
        let item17 = TableCell(type: .beverage, imageData: #imageLiteral(resourceName: "drink10").pngData(), title: "Moscato Lemonade", description: "Cheers to spring!")
        
        tempItems.append(contentsOf: [item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15, item16, item17])
        return tempItems
    }
}
