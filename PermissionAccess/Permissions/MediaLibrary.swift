//
//  MediaLibrary.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_MEDIA_LIBRARY
import Foundation

struct MediaLibrary: Permission {
    static let name = "\(MediaLibrary.self)"
    static let usageDescription = Bundle.main.object(forInfoDictionaryKey: "NSAppleMusicUsageDescription") as? String

    static var status: PermissionStatus {
        fatalError("Not Implemented.")
    }

    static func request(handler: PermissionHandler?) {
        guard let _ = usageDescription else {
            print("Missing \(name) usage description string in Info.plist")
            return
        }

        fatalError("Not Implemented.")
    }
}
#endif
