//
//  AppDelegate.swift
//  BuffaloBills
//
//  Created by venkata baisani on 14/09/23.
//

import UIKit
import CoreData
import Firebase
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    var notiStr = "Hey Jeff, \n\n Gate 2 is experiencing heavy queues. Please use Gate 3 for quicker entry. Thank you!"
    
    var launchOptionsLocal: [UIApplication.LaunchOptionsKey: Any]? = nil
    
    var localFCMToken: String? = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        launchOptionsLocal = launchOptions
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        Messaging.messaging().isAutoInitEnabled = true
        
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                
                
            }
        }
        
        if ( application.applicationState == .inactive || application.applicationState == .background ) {
            
            let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String : Any]
            
            
            if let aps = userInfo?["aps"] as? NSDictionary {
                if let alert = aps["alert"] as? NSDictionary {
                    if let message = alert["message"] as? NSString {
                        //Do stuff
                    }
                } else if let alert = aps["alert"] as? NSString {
                    //Do stuff
                    notiStr = alert as String
                    print(alert)
                    DispatchQueue.main.async {
                        
                        //                        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                        let alert = UIAlertController(title: "", message: self.notiStr, preferredStyle: .alert)
                        //                        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "SHLoginViewController")
                        let  navigationController: UINavigationController? = UINavigationController(rootViewController: controller)
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window?.rootViewController = navigationController
                        self.window!.makeKeyAndVisible()
                        
                        navigationController?.present(alert, animated: true)
                        
//                        let controllerNotification = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
//                        navigationController?.pushViewController(controllerNotification, animated: false)
                    }
                }
            }
        }
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        if ( application.applicationState == .inactive || application.applicationState == .background ) {
            let userInfo = launchOptionsLocal?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String : Any]
            
            if let aps = userInfo?["aps"] as? NSDictionary {
                if let alert = aps["alert"] as? NSDictionary {
                    if let message = alert["message"] as? NSString {
                        //Do stuff
                    }
                } else if let alert = aps["alert"] as? NSString {
                    //Do stuff
                    notiStr = alert as String
                    print(alert)
                    DispatchQueue.main.async {
                        
                        //                        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                        let alert = UIAlertController(title: "", message: self.notiStr, preferredStyle: .alert)
                        //                        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "SHLoginViewController")
                        let  navigationController: UINavigationController? = UINavigationController(rootViewController: controller)
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window?.rootViewController = navigationController
                        self.window!.makeKeyAndVisible()
                        
                        let controllerNotification = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
                        navigationController?.pushViewController(controllerNotification, animated: false)
                    }
                }
            }
        }
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
     localFCMToken = fcmToken
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }

  

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "BuffaloBills")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    //MARK: - Firebase messaging delegates
    
  
    @available(iOS 10, *)
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      let userInfo = notification.request.content.userInfo

      // Print full message.
      print(userInfo)
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                if let message = alert["message"] as? NSString {
                   //Do stuff
                }
            } else if let alert = aps["alert"] as? NSString {
                //Do stuff
                notiStr = alert as String
                print(alert)
            }
        }
        
       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filter"), object: nil)
        
        let keyWindow = UIApplication
            .shared
            .connectedScenes
            .flatMap({ ($0 as? UIWindowScene)?.windows ?? [] })
            .filter({$0.isKeyWindow})
            .first
        
        switch UIApplication.shared.applicationState {
        case .active:
            print("Active")
            
            let rootViewController:UINavigationController? = keyWindow?.rootViewController as? UINavigationController
            let count = rootViewController?.viewControllers.count ?? 0
            let viewControllerLast = (rootViewController?.viewControllers[count-1])
            if (viewControllerLast is NewsViewController || viewControllerLast is ChatbotViewController)  {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
                rootViewController?.pushViewController(controller, animated: false)
            }
            return
        case .inactive:
            print("userNotificationCenter inactive)")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SHLoginViewController")
            let  navigationController: UINavigationController? = UINavigationController(rootViewController: controller)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navigationController
            self.window!.makeKeyAndVisible()
            
            let controllerNotification = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
            navigationController?.pushViewController(controllerNotification, animated: false)
            
            break
        case .background:
            print("userNotificationCenter background")
            break
        @unknown default:
            
            let rootViewController:UINavigationController? = keyWindow?.rootViewController as? UINavigationController
            let count = rootViewController?.viewControllers.count ?? 0
            let viewControllerLast = (rootViewController?.viewControllers[count-1])
            if (viewControllerLast is NewsViewController || viewControllerLast is ChatbotViewController)  {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
                rootViewController?.pushViewController(controller, animated: false)
            }
            break
        }
      // Change this to your preferred presentation option
      completionHandler([[.badge,.sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
      
      // Print full message.
//        print(userInfo.startIndex)
        
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                if let message = alert["message"] as? NSString {
                   //Do stuff
                }
            } else if let alert = aps["alert"] as? NSString {
                //Do stuff
                notiStr = alert as String
                print(alert)
            }
        }
        
       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filter"), object: nil)
        
        let keyWindow = UIApplication
            .shared
            .connectedScenes
            .flatMap({ ($0 as? UIWindowScene)?.windows ?? [] })
            .filter({$0.isKeyWindow})
            .first
    
        
        switch UIApplication.shared.applicationState {
        case .active:
            print("Active")
            
            let rootViewController:UINavigationController? = keyWindow?.rootViewController as? UINavigationController
            let count = rootViewController?.viewControllers.count ?? 0
            let viewControllerLast = (rootViewController?.viewControllers[count-1])
            if (viewControllerLast is NewsViewController || viewControllerLast is ChatbotViewController)  {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
                rootViewController?.pushViewController(controller, animated: false)
            }
            return
        case .inactive:
            print("userNotificationCenter inactive)")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SHLoginViewController")
            let  navigationController: UINavigationController? = UINavigationController(rootViewController: controller)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navigationController
            self.window!.makeKeyAndVisible()
            
            let controllerNotification = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
            navigationController?.pushViewController(controllerNotification, animated: false)
            
            break
        case .background:
            print("userNotificationCenter background")
            break
        @unknown default:
            
            let rootViewController:UINavigationController? = keyWindow?.rootViewController as? UINavigationController
            let count = rootViewController?.viewControllers.count ?? 0
            let viewControllerLast = (rootViewController?.viewControllers[count-1])
            if (viewControllerLast is NewsViewController || viewControllerLast is ChatbotViewController)  {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
                rootViewController?.pushViewController(controller, animated: false)
            }
            break
        }
        


      completionHandler()
    }
    
   

}

