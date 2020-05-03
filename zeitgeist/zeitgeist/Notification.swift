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
    // Function for sendin notification
    func SendNotification(title: String, body: String) {
        // Request permission for notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
                print("notification permission OK")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        // Content of the notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        // Open option for the notification
        let open = UNNotificationAction(identifier: "open", title: "openText", options: .foreground)
        // Cancel option for the notification
        let cancel = UNNotificationAction(identifier: "cancel", title: "cancelText", options: .destructive)
        // Action from notification
        let categories = UNNotificationCategory(identifier: "action", actions: [open, cancel], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([categories])
        // Identifier for action
        content.categoryIdentifier = "action"
        // Time for the notification to appear (5 seconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        // Request for the notification
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // The central object for managing notification-related activities
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
