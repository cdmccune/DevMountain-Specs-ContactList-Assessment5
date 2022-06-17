//
//  AppDelegate.swift
//  ContactList
//
//  Created by Curt McCune on 6/17/22.
//

import UIKit
import CloudKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        self.checkICloudStatus { success in
            success ? print("iCloud Verified") : DispatchQueue.main.async {
                self.window?.rootViewController?.presentsSimpleAlertWith(title: "Error signing in to iCloud", message: nil)
            }
        }
        return true
    }
    
    func checkICloudStatus(completion: @escaping (Bool) -> Void) {
        CKContainer.default().accountStatus { status, error in
            if let error = error {
                print("There was an error signing into icloud \(error.localizedDescription)")
                return completion(false)
            }
            
            switch status {
            case .couldNotDetermine:
                return completion(false)
            case .available:
                return completion(true)
            case .restricted:
                return completion(false)
            case .noAccount:
                return completion(false)
            case .temporarilyUnavailable:
                return completion(false)
            @unknown default:
                return completion(false)
            }
        }
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
    
    
}

