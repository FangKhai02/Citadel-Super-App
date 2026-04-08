//
//  NotificationService.swift
//  OneSignalNotificationServiceExtension
//
//  Created by james ong on 27/11/2024.
//

import UserNotifications
import OneSignalExtension

class NotificationService: UNNotificationServiceExtension {
    
    var receivedRequest: UNNotificationRequest!
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        self.receivedRequest = request
        self.contentHandler = contentHandler
        self.bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            
            OneSignalExtension.didReceiveNotificationExtensionRequest(self.receivedRequest, with: bestAttemptContent, withContentHandler: self.contentHandler)
            
            NotificationService.storeToInbox(self.bestAttemptContent!)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            OneSignalExtension.serviceExtensionTimeWillExpireRequest(self.receivedRequest, with: self.bestAttemptContent)
            contentHandler(bestAttemptContent)
        }
    }
    
    class func storeToInbox(_ notification: UNMutableNotificationContent) {
        var notificationId: String = "";
        var launchUrl: String = "";
        if let custom = notification.userInfo["custom"] as? Dictionary<String, Any> {
            if let attribute = custom["a"] as? Dictionary<String, Any> {
                return;
            };
            
            notificationId = custom["i"] as? String ?? ""
            launchUrl = custom["u"] as? String ?? ""
        }
        
        let title = notification.title
        let message = notification.body
        let createdDate = Date().timeIntervalSince1970 * 1000
        let date : Int = Int(round(createdDate))
        
        var imageUrl = ""
        if let att = notification.userInfo["att"] as? Dictionary<String, Any> {
            imageUrl = att["id1"] as? String ?? (att["id"] as? String ?? "")
        }
        
        let notification: [String:Any] = ["title": title, "message": message, "imageUrl": imageUrl, "date": date, "notificationId": notificationId, "launchUrl": launchUrl]
        UserInbox.saveInbox(message: notification)
    }
    
}
