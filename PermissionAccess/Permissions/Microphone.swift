//
//  Microphone.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/02.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_MICROPHONE
import AVFoundation

struct Microphone: Permission {
    static let name = "\(Microphone.self)"
    static let usageDescription = Bundle.main.object(forInfoDictionaryKey: "NSMicrophoneUsageDescription") as? String

    static var status: PermissionStatus {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
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
            AVCaptureDevice.requestAccess(for: .audio) { (isAuthorized) in handler?(isAuthorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
#endif
