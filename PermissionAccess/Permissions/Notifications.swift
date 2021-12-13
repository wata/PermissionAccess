//
//  Notifications.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/02.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_NOTIFICATIONS
import UserNotifications

struct Notifications: Permission {
    static let name = "\(Notification.self)"
    static let usageDescription: String? = nil

    static var options: UNAuthorizationOptions = []

    static var status: PermissionStatus {
        guard UserDefaults.standard.requestedNotifications else {
            return .notDetermined
        }
        let semaphore = DispatchSemaphore(value: 0)
        var status: PermissionStatus = .notDetermined
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            defer { semaphore.signal() }
            switch settings.authorizationStatus {
            case .authorized, .provisional: status = .authorized
            case .notDetermined: status = .notDetermined
            case .denied: status = .denied
            @unknown default: fatalError("Unknown status")
            }
        }
        semaphore.wait()
        return status
    }

    static func request(handler: PermissionHandler?) {
        UserDefaults.standard.requestedNotifications = true
        let currentStatus = status
        switch currentStatus {
        case .notDetermined:
            UNUserNotificationCenter.current().requestAuthorization(options: options) { (isAuthorized, _) in handler?(isAuthorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
#endif
