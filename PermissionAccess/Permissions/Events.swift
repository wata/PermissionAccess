//
//  Events.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation

struct Events: Permission {
    static let name: String = "\(Events.self)"
    static let usageDescription: String? = nil

    static var status: PermissionStatus {
        fatalError("Not Implemented.")
    }

    static func request(handler: PermissionHandler?) {
        fatalError("Not Implemented.")
    }
}
