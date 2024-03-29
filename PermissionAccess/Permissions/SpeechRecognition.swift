//
//  SpeechRecognition.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/07/21.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_SPEECH_RECOGNITION
import Speech

struct SpeechRecognition: Permission {
    static let name = "\(SpeechRecognition.self)"
    static let usageDescription = Bundle.main.object(forInfoDictionaryKey: "NSSpeechRecognitionUsageDescription") as? String

    static var status: PermissionStatus {
        switch SFSpeechRecognizer.authorizationStatus() {
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
            SFSpeechRecognizer.requestAuthorization { (status) in handler?(status == .authorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
#endif
