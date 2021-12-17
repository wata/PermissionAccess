//
//  Contacts.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/02.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_CONTACTS
import Contacts

struct Contacts: Permission {
    static let name = "\(Contacts.self)"
    static let usageDescription = Bundle.main.object(forInfoDictionaryKey: "NSContactsUsageDescription") as? String

    static var status: PermissionStatus {
        switch CNContactStore.authorizationStatus(for: .contacts) {
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
            CNContactStore().requestAccess(for: .contacts) { (isAuthorized, _) in handler?(isAuthorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
#endif
