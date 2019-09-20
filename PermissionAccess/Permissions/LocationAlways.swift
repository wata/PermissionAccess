//
//  LocationAlways.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/01.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation
import CoreLocation

fileprivate let locationManager = CLLocationManager()
fileprivate var delegate: LocationManagerDelegate!
fileprivate var resignActiveObserver: NSObjectProtocol!
fileprivate var becomeActiveObserver: NSObjectProtocol!
fileprivate var requestingAuthorization = false

struct LocationAlways: Permission {
    static let name: String = "\(LocationAlways.self)"
    static let usageDescription: String? = Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") as? String

    static var status: PermissionStatus {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways: return .authorized
        case .authorizedWhenInUse: return UserDefaults.standard.requestedLocationAlwaysWithWhenInUse ? .denied : .notDetermined
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

        setupLocationManagerDelegate(handler: handler)

        let currentStatus = status
        switch currentStatus {
        case .notDetermined:
            UserDefaults.standard.requestedLocationAlwaysWithWhenInUse = true
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                // Prepare for the escalation request.
                setupApplicationObserver(handler: handler)
            }
            locationManager.requestAlwaysAuthorization()
        default:
            handler?(currentStatus.isAuthorized)
        }
    }

    private static func setupLocationManagerDelegate(handler: PermissionHandler?) {
        delegate = LocationManagerDelegate(statusHandler: { handler?(status.isAuthorized) })
        locationManager.delegate = delegate
    }

    private static func setupApplicationObserver(handler: PermissionHandler?) {
        resignActiveObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.willResignActiveNotification,
            object: nil,
            queue: nil
        ) { (_) in
            requestingAuthorization = true
            NotificationCenter.default.removeObserver(resignActiveObserver!)
        }
        becomeActiveObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: nil
        ) { (_) in
            guard requestingAuthorization else { return }
            requestingAuthorization = false
            NotificationCenter.default.removeObserver(becomeActiveObserver!)
            // If the user denies the escalation request, `didChangeAuthorizationStatus` is never called.
            guard status == .denied else { return }
            handler?(false)
        }
    }
}
