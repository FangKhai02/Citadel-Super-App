//
//  UserInbox.swift
//  Runner
//
//  Created by Jing Wei Toh on 13/10/2021.
//

import Foundation

class UserInbox: NSObject {
    static let getPublicInboxNotification = "getPublicInboxNotification"
    static let deletePublicInboxNotification = "deletePublicInboxNotification"
    
    class func saveInbox(message: [String:Any]){
        var inbox : [String: [[String: Any]]] = [:]
        var inboxStorage : [[String: Any]] = []
        
        inbox = SharedPreferences().getObject("flutter.inbox") as? [String: [[String : Any]]] ?? [:]
        let inboxName = "inbox-public"
        
        if let _inboxStorage = inbox[inboxName] {
            inboxStorage = _inboxStorage
        } else {
            inboxStorage = []
        }
        
        inboxStorage.append(message)
        inbox[inboxName] = inboxStorage
        SharedPreferences().setObject(inbox, key: "flutter.inbox")
    }
    
    class func retrieveAllInbox() -> [[String:Any]]{
        let inbox = SharedPreferences().getObject("flutter.inbox") as? [String: [[String : Any]]] ?? [:]
        var userInbox: [[String:Any]] = []
        
        let inboxName = "inbox-public"
        userInbox = inbox[inboxName] ?? []
        
        return userInbox
    }
    
    class func clearAllInbox(){
        var inbox = SharedPreferences().getObject("flutter.inbox") as? [String: [[String : Any]]] ?? [:]
        
        let inboxName = "inbox-public"
        inbox[inboxName] = []
        
        SharedPreferences().setObject(inbox, key: "flutter.inbox")
        
    }
}
