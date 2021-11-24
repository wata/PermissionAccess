//
//  LocationWhenInUse.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/02.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation
import CoreLocation

fileprivate let locationManager = CLLocationManager()
fileprivate var delegate: LocationManagerDelegate!

struct LocationWhenInUse: Permission {
    static let name = "\(LocationWhenInUse.self)"
    static let usageDescription = Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") as? String

    static var status: PermissionStatus {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways: return .authorized
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
            locationManager.requestWhenInUseAuthorization()
        default:
            handler?(currentStatus.isAuthorized)
        }
    }

    private static func setupLocationManagerDelegate(handler: PermissionHandler?) {
        delegate = LocationManagerDelegate(statusHandler: { handler?(status.isAuthorized) })
        locationManager.delegate = delegate
    }
}
