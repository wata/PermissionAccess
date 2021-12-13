//
//  PermissionAccess.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/01.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation

public typealias PermissionHandler = (Bool) -> Void

public protocol Permission {
    static var name: String { get }
    static var usageDescription: String? { get }
    static var status: PermissionStatus { get }
    static func request(handler: PermissionHandler?)
}

public struct PermissionAccess {
    private init() {}

    public static func hasPermission(_ type: PermissionType) -> Bool {
        type.permission.status.isAuthorized
    }

    public static func status(_ type: PermissionType) -> PermissionStatus {
        type.permission.status
    }

    public static func request(_ type: PermissionType, presentDeniedAlert: Bool = false, handler: PermissionHandler? = nil) {
        type.permission.request { (isAuthorized) in
            if !isAuthorized, presentDeniedAlert {
                presentDeniedAlertController(permissionName: type.permission.name, handler: handler)
                return
            }
            DispatchQueue.main.async {
                handler?(isAuthorized)
            }
        }
    }

    public static func presentDeniedAlertController(permissionName: String,
                                                    title: String? = nil,
                                                    message: String? = nil,
                                                    handler: PermissionHandler?) {
        DispatchQueue.main.async {
            let controller = UIAlertController(
                title: title ?? "Permission for \(permissionName) was denied",
                message: message ?? "Please enable access to \(permissionName) in the Settings app.",
                preferredStyle: .alert
            )
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (_) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                handler?(false)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                handler?(false)
            })
            controller.addAction(settingsAction)
            controller.addAction(cancelAction)
            controller.preferredAction = settingsAction
            UIApplication.shared.presentViewController(controller)
        }
    }
}
