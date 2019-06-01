//
//  PermissionStatus.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/01.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation

public enum PermissionStatus: String {
    case authorized
    case notDetermined
    case denied
    case disabled

    public var isAuthorized: Bool { return self == .authorized }
}
