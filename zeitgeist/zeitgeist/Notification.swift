//
//  Notification.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 30.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import UserNotifications

class Notification {
    
    func SendNotification(title: String, body: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
                print("notification permission OK")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
        
        let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
        
        let categories = UNNotificationCategory(identifier: "action", actions: [open, cancel], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([categories])
        
        content.categoryIdentifier = "action"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "request", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
