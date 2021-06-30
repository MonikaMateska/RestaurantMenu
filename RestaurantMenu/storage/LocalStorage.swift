//
//  LocalStorage.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 5/8/21.
//

import Foundation

protocol LocalStorage {
    
    func save(value: Any?, forKey key: String)
    
    func value(forKey key: String) -> Any?
    
    func bool(forKey key: String) -> Bool
    
    func clearData()
    
}
