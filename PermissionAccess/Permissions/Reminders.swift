//
//  Reminders.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation
import EventKit

struct Reminders: Permission {
    static let name = "\(Reminders.self)"
    static let usageDescription: String? = nil

    static var status: PermissionStatus {
        switch EKEventStore.authorizationStatus(for: .reminder) {
        case .authorized: return .authorized
        case .notDetermined: return .notDetermined
        case .restricted, .denied: return .denied
        @unknown default: fatalError("Unknown status")
        }
    }

    static func request(handler: PermissionHandler?) {
        let currentStatus = status
        switch currentStatus {
        case .notDetermined:
            EKEventStore().requestAccess(to: .reminder) { isAuthorized, _ in handler?(isAuthorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
