//
//  Motion.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/08/04.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

#if PERMISSION_MOTION
import CoreMotion

fileprivate let motionActivityManager = CMMotionActivityManager()

struct Motion: Permission {
    static let name = "\(Motion.self)"
    static let usageDescription: String? = nil

    static var status: PermissionStatus {
        guard UserDefaults.standard.requestedMotion else {
            return .notDetermined
        }
        let semaphore = DispatchSemaphore(value: 0)
        var status: PermissionStatus = .notDetermined
        let now = Date()
        motionActivityManager.queryActivityStarting(from: now, to: now, to: .background) { (_, error) in
            motionActivityManager.stopActivityUpdates()
            defer { semaphore.signal() }
            if let error = error, error._code == Int(CMErrorMotionActivityNotAuthorized.rawValue) {
                status = .denied
            } else {
                status = .authorized
            }
        }
        semaphore.wait()
        return status
    }

    static func request(handler: PermissionHandler?) {
        UserDefaults.standard.requestedMotion = true
        let now = Date()
        motionActivityManager.queryActivityStarting(from: now, to: now, to: .main) { (_, error) in
            motionActivityManager.stopActivityUpdates()
            let status: PermissionStatus
            if let error = error, error._code == Int(CMErrorMotionActivityNotAuthorized.rawValue) {
                status = .denied
            } else {
                status = .authorized
            }
            handler?(status.isAuthorized)
        }
    }
}
#endif
