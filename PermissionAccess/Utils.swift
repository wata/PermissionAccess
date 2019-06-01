//
//  Utils.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/01.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import UIKit
import CoreLocation

extension UIApplication {
    var topViewController: UIViewController? {
        var vc = delegate?.window??.rootViewController
        while let presentedVC = vc?.presentedViewController {
            vc = presentedVC
        }
        return vc
    }

    func presentViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        topViewController?.present(viewController, animated: animated, completion: completion)
    }
}

fileprivate extension String {
    static let requestedNotifications               = "permissionAccess.requestedNotifications"
    static let requestedLocationAlwaysWithWhenInUse = "permissionAccess.requestedLocationAlwaysWithWhenInUse"
    static let requestedMotion                      = "permissionAccess.requestedMotion"
    static let requestedBluetooth                   = "permissionAccess.requestedBluetooth"
    static let statusBluetooth                      = "permissionAccess.statusBluetooth"
    static let stateBluetoothManagerDetermined      = "permissionAccess.stateBluetoothManagerDetermined"
}

extension UserDefaults {
    var requestedLocationAlwaysWithWhenInUse: Bool {
        get { return bool(forKey: .requestedLocationAlwaysWithWhenInUse) }
        set { set(newValue, forKey: .requestedLocationAlwaysWithWhenInUse) }
    }

    var requestedNotifications: Bool {
        get { return bool(forKey: .requestedNotifications) }
        set { set(newValue, forKey: .requestedNotifications) }
    }

    var requestedMotion: Bool {
        get { return bool(forKey: .requestedMotion) }
        set { set(newValue, forKey: .requestedMotion) }
    }

    var requestedBluetooth: Bool {
        get { return bool(forKey: .requestedBluetooth) }
        set { set(newValue, forKey: .requestedBluetooth) }
    }

    var statusBluetooth: PermissionStatus? {
        get { return PermissionStatus(rawValue: string(forKey: .statusBluetooth) ?? "") }
        set { set(newValue?.rawValue, forKey: .statusBluetooth) }
    }

    var stateBluetoothManagerDetermined: Bool {
        get { return bool(forKey: .stateBluetoothManagerDetermined) }
        set { set(newValue, forKey: .stateBluetoothManagerDetermined) }
    }
}

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    let currentStatus = CLLocationManager.authorizationStatus()
    let statusHandler: () -> Void

    init(statusHandler: @escaping () -> Void) {
        self.statusHandler = statusHandler
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // `didChangeAuthorizationStatus` is called once when the `CLLocationManager` is initialized.
        // https://stackoverflow.com/a/30107511/11226828
        guard status != currentStatus else { return }
        NotificationCenter.default.post(name: .locationPermissionStatusChanged, object: nil)
        statusHandler()
    }
}

public extension Notification.Name {
    /// A notification posted when the status of the location permission have changed.
    static let locationPermissionStatusChanged = Notification.Name("permissionAccess.locationPermissionStatusChanged")
}
