//
//  UserDefaultsStorage.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 5/8/21.
//

import Foundation

class UserDefaultsStorage: LocalStorage {
    
    func bool(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey:key)
    }
    
    func save(value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func value(forKey key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    func clearData() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
    
}
