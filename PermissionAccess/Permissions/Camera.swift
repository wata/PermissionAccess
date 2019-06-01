//
//  Camera.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/02.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation
import AVFoundation

struct Camera: Permission {
    static let name: String = "\(Camera.self)"
    static let usageDescription: String? = Bundle.main.object(forInfoDictionaryKey: "NSCameraUsageDescription") as? String

    static var status: PermissionStatus {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
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
            AVCaptureDevice.requestAccess(for: .video) { (isAuthorized) in handler?(isAuthorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
