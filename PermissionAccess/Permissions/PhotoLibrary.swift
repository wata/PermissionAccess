//
//  PhotoLibrary.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/02.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_PHOTO_LIBRARY
import Photos

struct PhotoLibrary: Permission {
    static let name = "\(PhotoLibrary.self)"
    static let usageDescription = Bundle.main.object(forInfoDictionaryKey: "NSPhotoLibraryUsageDescription") as? String

    static var status: PermissionStatus {
        switch PHPhotoLibrary.authorizationStatus() {
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
            PHPhotoLibrary.requestAuthorization { (status) in handler?(status == .authorized) }
        default:
            handler?(currentStatus.isAuthorized)
        }
    }
}
#endif
