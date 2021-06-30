//
//  WinePairingResponseModel.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 5/15/21.
//

import Foundation
import UIKit

struct WinePairingResponseModel: Codable {
    let pairedWines: [String]
    let pairingText: String
    let productMatches: [ProductModel]
}

struct ProductModel: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let imageUrl: String
    let link: String
}

struct ProductDisplayModel {
    let title: String
    let description: String
    let price: String
    let image: UIImage
    let link: String
}
