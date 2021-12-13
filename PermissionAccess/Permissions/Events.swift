//
//  Events.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_EVENTS
import EventKit

struct Events: Permission {
    static let name = "\(Events.self)"
    static let usageDescription: String? = nil

    static var status: PermissionStatus {
        switch EKEventStore.authorizationStatus(for: .event) {
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
            EKEventStore().requestAccess(to: .event) { isAuthorized, _ in handler?(isAuthorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
#endif
