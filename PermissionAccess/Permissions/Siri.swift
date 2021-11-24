//
//  Siri.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation
import Intents

struct Siri: Permission {
    static let name = "\(Siri.self)"
    static let usageDescription = Bundle.main.object(forInfoDictionaryKey: "NSSiriUsageDescription") as? String

    static var status: PermissionStatus {
        switch INPreferences.siriAuthorizationStatus() {
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
            INPreferences.requestSiriAuthorization { (status) in handler?(status == .authorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
