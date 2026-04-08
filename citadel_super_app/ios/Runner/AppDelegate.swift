import Flutter
import UIKit
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
    let inboxChannel = "com.citadel.super_app.inbox"
    var inboxMethodChannel: FlutterMethodChannel?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        FirebaseApp.configure()
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        inboxMethodChannel = FlutterMethodChannel(name: inboxChannel,
                                                  binaryMessenger: controller.binaryMessenger)
        inboxMethodChannel?.setMethodCallHandler(inboxHandler)
        
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func inboxHandler(call:FlutterMethodCall, result:FlutterResult) {
        switch (call.method) {
        case UserInbox.getPublicInboxNotification:
            result(UserInbox.retrieveAllInbox())
            break;
        case UserInbox.deletePublicInboxNotification:
            UserInbox.clearAllInbox()
            result(true)
            break;
        default:
            return;
        }
        
    }
}
