//
//  SharedPreferences.swift
//  Runner
//
//  Created by Jing Wei Toh on 13/10/2021.
//

import Foundation

class SharedPreferences: NSObject {
        
    let pref = UserDefaults(suiteName: "com.citadel.group")
    
    func setObject(_ object: Any, key: String) {
        pref?.set(object, forKey: key)
    }
    
    func getObject(_ key:String) -> AnyObject? {
        if let prefObj = pref?.object(forKey: key) {
            return prefObj as AnyObject
        }
         
        return nil
    }
}
