//
//  Contacts.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/02.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation
import Contacts

struct Contacts: Permission {
    static let name = "\(Contacts.self)"
    static let usageDescription: String? = nil

    static var status: PermissionStatus {
        switch CNContactStore.authorizationStatus(for: .contacts) {
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
            CNContactStore().requestAccess(for: .contacts) { (isAuthorized, _) in handler?(isAuthorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
