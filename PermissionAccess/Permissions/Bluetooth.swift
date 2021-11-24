//
//  Bluetooth.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation

struct Bluetooth: Permission {
    static let name = "\(Bluetooth.self)"
    static let usageDescription: String? = nil

    static var status: PermissionStatus {
        fatalError("Not Implemented.")
    }

    static func request(handler: PermissionHandler?) {
        fatalError("Not Implemented.")
    }
}
