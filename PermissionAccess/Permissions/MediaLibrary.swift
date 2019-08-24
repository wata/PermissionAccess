//
//  MediaLibrary.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation

struct MediaLibrary: Permission {
    static let name: String = "\(MediaLibrary.self)"
    static let usageDescription: String? = Bundle.main.object(forInfoDictionaryKey: "NSAppleMusicUsageDescription") as? String

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
