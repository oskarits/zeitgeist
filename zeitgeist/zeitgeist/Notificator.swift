//
//  Notificator.swift
//  zeitgeist
//
//  Created by Oskari Sieranen on 24.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import UserNotifications

class Notificator {
    func PermissionRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            success, error in
            if success {
                print("notification permission OK")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    // add trigger argument
    func ScheduleNotification(title: String, subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
}
