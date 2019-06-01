//
//  Siri.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation

struct Siri: Permission {
    static let name: String = "\(Siri.self)"
    static let usageDescription: String? = Bundle.main.object(forInfoDictionaryKey: "NSSiriUsageDescription") as? String

    static var status: PermissionStatus {
        fatalError("Not Implemented.")
    }

    static func request(handler: PermissionHandler?) {
        fatalError("Not Implemented.")
    }
}
