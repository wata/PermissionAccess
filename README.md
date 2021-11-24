# PermissionAccess
A unified API to ask for permissions on iOS.

## Supported Permissions

- [ ] Bluetooth
- [x] Camera
- [x] Contacts
- [x] Events
- [x] Motion
- [x] Microphone
- [x] Notifications
- [x] PhotoLibrary
- [x] Reminders
- [x] LocationAlways
- [x] LocationWhenInUse
- [x] MediaLibrary
- [x] SpeechRecognizer
- [x] Siri

## Usage

```swift
PermissionAccess.request(.contacts, presentDeniedAlert: true) { (isAuthorized) in
    print(isAuthorized)
}

// Returns a authorization status of authorized / notDetermined / denied / disabled.
PermissionAccess.status(.contacts)

// Returns a Boolean value that indicates whether the permission is granted.
PermissionAccess.hasPermisson(.contacts)
```

### `locationPermissionStatusChanged` notification

A notification posted when the status of the location permission have changed.

```swift
let observer = NotificationCenter.default.addObserver(forName: .locationPermissionStatusChanged, object: nil, queue: .main) { (_) in
    print(PermissionAccess.hasPermission(.locationAlways))
}

PermissionAccess.request(.locationAlways)
```

### Custom permission group with [PromiseKit](https://github.com/mxcl/PromiseKit)

```swift
import PromiseKit

extension PermissionAccess {
    static var myMovieCameraStatus: PermissionStatus {
        let statuses = [status(.camera), status(.microphone), status(.photoLibrary)]
        if statuses.elementsEqual([.authorized, .authorized, .authorized]) {
            return .authorized
        }
        if statuses.contains(.denied) {
            return .denied
        }
        return .notDetermined
    }

    static var hasMyMovieCameraPermission: Bool {
        return myMovieCameraStatus.isAuthorized
    }

    static func requestMyMovieCamera(presentDeniedAlert: Bool = false, handler: PermissionHandler? = nil) {
        let error = NSError(domain: "", code: 0, userInfo: nil)
        firstly {
            return Promise { (seal) in
                request(.camera, presentDeniedAlert: false) { (isAuthorized) in
                    isAuthorized ? seal.fulfill(()) : seal.reject(error)
                }
            }
        }.then {
            return Promise { (seal) in
                request(.microphone, presentDeniedAlert: false) { (isAuthorized) in
                    isAuthorized ? seal.fulfill(()) : seal.reject(error)
                }
            }
        }.then {
            return Promise { (seal) in
                request(.photoLibrary, presentDeniedAlert: false) { (isAuthorized) in
                    isAuthorized ? seal.fulfill(()) : seal.reject(error)
                }
            }
        }.done {
            handler?(true)
        }.catch { (_) in
            if presentDeniedAlert {
                presentDeniedAlertController(permissionName: "", title: "My title", message: "My message", handler: handler)
            } else {
                handler?(false)
            }
        }
    }
}
```
