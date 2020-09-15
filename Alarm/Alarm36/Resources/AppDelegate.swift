//
//  AppDelegate.swift
//  Alarm36
//
//  Created by Shean Bjoralt on 9/14/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AlarmController.shared.loadFromPersistentStore()
        requestNotificationsPermision()
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func requestNotificationsPermision() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (success, _) in
            if success {
                print("Notifications allowed!")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}

