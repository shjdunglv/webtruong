//
//  AppDelegate.swift
//  RaoViet
//
//  Created by Chung on 11/28/16.
//  Copyright © 2016 3i. All rights reserved.
//

import UIKit
import CoreData
import DropDown
import Google
import UserNotifications
import SwiftyJSON
import AudioToolbox
import Alamofire
import SlideMenuControllerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let manager = NetworkReachabilityManager()
    var connectedToGCM = false
    var subscribedToTopic = false
    var gcmSenderID:String?
    var registrationToken: String?
    var registrationOptions = [String: AnyObject]()
    
    let registrationKey = "onRegistrationCompleted"
    let messageKey = "onMessageReceived"
    let subscriptionTopic = "/topics/global"
    var message: String = ""
    
    let userDefault = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        configGCM(application: application)
        
        
        //config payment
        PayPalMobile .initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AQDR8YpJnF1lDTs_NUm1gMDKuWZdZmvco9I3mgG13eBJ9Gg5J1k_5-K5Sg5A6OXWlvSKEnpk6NOMHIfN", PayPalEnvironmentSandbox: "chungvtgc00989-facilitator@fpt.edu.vn"])
        
        
        DropDown.startListeningToKeyboard()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let _ = userDefault.object(forKey: LoginViewController.KEY_PASSWORD) as? String , let _ = userDefault.object(forKey:
            LoginViewController.KEY_PHONE_EMAIL) as? String{
            setDataForUser()

            let tabbar = BaseTabbar()
            let nav = BaseNavigation(rootViewController: tabbar)
            let menuVC = MenuViewController(nibName: "MenuViewController", bundle: nil)
            let slideMenuController = SlideMenuController(mainViewController: nav, leftMenuViewController: menuVC)
            self.window?.rootViewController = slideMenuController
            self.window?.makeKeyAndVisible()
        }else {
            let welcome = Welcome(nibName: "Welcome", bundle: nil)
            self.window?.rootViewController = welcome
           //let autopost = AutoPost(nibName: "AutoPost", bundle: nil)
            //self.window?.rootViewController = autopost
        }
        
        self.window?.makeKeyAndVisible()
        return true
    }
    func setDataForUser() {
        if let id = userDefault.object(forKey: LoginViewController.USER_ID) as? String , let name = userDefault.object(forKey:
            LoginViewController.USER_NAME) as? String, let email = userDefault.object(forKey:
            LoginViewController.USER_EMAIL) as? String, let picture = userDefault.object(forKey:
            LoginViewController.USER_picture) as? String{
            let user = User()
            user.id = id
            user.email = email
            user.display_name = name
            user.picture_profile = picture
            UserData.instance.user = user
            
        }
    }
    func configGCM (application: UIApplication) {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        //        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        gcmSenderID = GGLContext.sharedInstance().configuration.gcmSenderID
        //config notify
        //        if #available(iOS 8.0, *) {
        //            let settings: UIUserNotificationSettings =
        //                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        //            application.registerUserNotificationSettings(settings)
        //            application.registerForRemoteNotifications()
        //        } else {
        //            // Fallback
        //            let types: UIRemoteNotificationType = [.alert, .badge, .sound]
        //            application.registerForRemoteNotifications(matching: types)
        //        }
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        
        // [START start_gcm_service]
        let gcmConfig = GCMConfig.default()
        gcmConfig?.receiverDelegate = self
        GCMService.sharedInstance().start(with: gcmConfig)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    // [START disconnect_from_fcm]
    func applicationDidEnterBackground(_ application: UIApplication) {
        GCMService.sharedInstance().disconnect()
        // [START_EXCLUDE]
        //                self.connectedToGCM = false
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    // [START connect_on_active]
    func applicationDidBecomeActive(_ application: UIApplication) {
        GCMService.sharedInstance().connect(handler: { error -> Void in
            if let error = error as? NSError {
                print("Could not connect to GCM: \(error.localizedDescription)")
            } else {
                //                                self.connectedToGCM = true
                print("Connected to GCM")
                // [START_EXCLUDE]
                //                                self.subscribeToTopic()
                // [END_EXCLUDE]
            }
        })    }
    // [END connect_on_active]
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.3i.RaoViet" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "RaoViet", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
extension AppDelegate {
    
    func subscribeToTopic() {
        
        if registrationToken != nil && connectedToGCM {
            GCMPubSub.sharedInstance().subscribe(withToken: self.registrationToken, topic: subscriptionTopic,
                                                 options: nil, handler: { error -> Void in
                                                    if let error = error as? NSError {
                                                        // Treat the "already subscribed" error more gently
                                                        if error.code == 3001 {
                                                            print("Already subscribed to \(self.subscriptionTopic)")
                                                        } else {
                                                            print("Subscription failed: \(error.localizedDescription)")
                                                        }
                                                    } else {
                                                        self.subscribedToTopic = true
                                                        NSLog("Subscribed to \(self.subscriptionTopic)")
                                                    }
            })
        }
    }
    
    
    
    func registrationHandler(_ registrationToken: String?, error: Error?) {
        if let registrationToken = registrationToken {
            self.registrationToken = registrationToken
            print("Registration Token: \(registrationToken)")
            self.subscribeToTopic()
            let userInfo = ["registrationToken": registrationToken]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: self.registrationKey), object: nil, userInfo: userInfo)
        } else if let error = error {
            print("Registration to GCM failed with error: \(error.localizedDescription)")
            let userInfo = ["error": error.localizedDescription]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: self.registrationKey), object: nil, userInfo: userInfo)
        }
    }
    
    
    
    
    // [END connect_to_fcm]
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Registration for remote notification failed with error: \(error.localizedDescription)")
        // [END receive_apns_token_error]
        let userInfo = ["error": error.localizedDescription]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: registrationKey), object: nil, userInfo: userInfo)
    }
    // the InstanceID token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // [START get_gcm_reg_token]
        let instanceIDConfig = GGLInstanceIDConfig.default()
        instanceIDConfig?.delegate = self
        // token to enable reception of notifications
        GGLInstanceID.sharedInstance().start(with: instanceIDConfig)
        registrationOptions = [kGGLInstanceIDRegisterAPNSOption:deviceToken as AnyObject,
                               kGGLInstanceIDAPNSServerTypeSandboxOption:true as AnyObject]
        GGLInstanceID.sharedInstance().token(withAuthorizedEntity: gcmSenderID,
                                             scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
        // [END get_gcm_reg_token]
        
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        print("state \(application.applicationState)")
        GCMService.sharedInstance().appDidReceiveMessage(userInfo)
        // Handle the received message
        NotificationCenter.default.post(name: Notification.Name(rawValue: messageKey), object: nil,userInfo: userInfo)
        
        print(userInfo)
        print("-----")
        parseJson(txt: userInfo["message"] as! String)
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10) as Date
        localNotification.applicationIconBadgeNumber = 2
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertBody = userInfo["message"] as! String?
        UIApplication.shared.scheduleLocalNotification(localNotification)
        DispatchQueue.main.async {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            AudioServicesPlayAlertSound(SystemSoundID.init(exactly: 1055)!)
        }
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("state \(application.applicationState)")
        print("Notification received: \(userInfo)")
        // This works only if the app started the GCM service
        GCMService.sharedInstance().appDidReceiveMessage(userInfo)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: messageKey), object: nil,
                                        userInfo: userInfo)
        
        print(userInfo)
        print("-----")
        parseJson(txt: userInfo["message"] as! String)
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10) as Date
        localNotification.applicationIconBadgeNumber = 2
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertBody = userInfo["message"] as! String?
        UIApplication.shared.scheduleLocalNotification(localNotification)
        DispatchQueue.main.async {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            AudioServicesPlayAlertSound(SystemSoundID.init(exactly: 1055)!)
        }
        
        
        completionHandler(UIBackgroundFetchResult.noData)
        // [END_EXCLUDE]
        
    }
    func parseJson(txt: String) {
        let dataString: Data = txt.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let json = JSON(data: dataString)
        if let message = json["message"].string {
            self.message = message
        }
    }
    
    
}
extension AppDelegate: GCMReceiverDelegate {
    func willSendDataMessage(withID messageID: String!, error: Error!) {
        if error != nil {
            // Failed to send the message.
        } else {
            // Will send message, you can save the messageID to track the message
        }
    }
    
    func didSendDataMessage(withID messageID: String!) {
        // Did successfully send message identified by messageID
    }
    // [END upstream_callbacks]
    
    func didDeleteMessagesOnServer() {
        // Some messages sent to this device were deleted on the GCM server before reception, likely
        // because the TTL expired. The client should notify the app server of this, so that the app
        // server can resend those messages.
    }
    
    
}
extension AppDelegate: GGLInstanceIDDelegate {
    // [START on_token_refresh]
    func onTokenRefresh() {
        // A rotation of the registration tokens is happening, so the app needs to request a new token.
        print("The GCM registration token needs to be changed.")
        GGLInstanceID.sharedInstance().token(withAuthorizedEntity: gcmSenderID,
                                             scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
    }
}



