//
//  Bluetooth.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_BLUETOOTH
import Foundation

struct Bluetooth: Permission {
    static let name = "\(Bluetooth.self)"
    static let usageDescription = Bundle.main.object(forInfoDictionaryKey: "NSBluetoothAlwaysUsageDescription") as? String

    static var status: PermissionStatus {
        fatalError("Not Implemented.")
    }

    static func request(handler: PermissionHandler?) {
        fatalError("Not Implemented.")
    }
}
#endif
