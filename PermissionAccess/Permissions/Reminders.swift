//
//  Reminders.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_REMINDERS
import EventKit

struct Reminders: Permission {
    static let name = "\(Reminders.self)"
    static let usageDescription = Bundle.main.object(forInfoDictionaryKey: "NSRemindersUsageDescription") as? String

    static var status: PermissionStatus {
        switch EKEventStore.authorizationStatus(for: .reminder) {
        case .authorized: return .authorized
        case .notDetermined: return .notDetermined
        case .restricted, .denied: return .denied
        @unknown default: fatalError("Unknown status")
        }
    }

    static func request(handler: PermissionHandler?) {
        guard let _ = usageDescription else {
            print("Missing \(name) usage description string in Info.plist")
            return
        }

        let currentStatus = status
        switch currentStatus {
        case .notDetermined:
            EKEventStore().requestAccess(to: .reminder) { isAuthorized, _ in handler?(isAuthorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
#endif
