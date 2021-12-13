//
//  PermissionType.swift
//  PermissionAccess
//
//  Created by Wataru Nagasawa on 2019/06/02.
//  Copyright © 2019 Wataru Nagasawa. All rights reserved.
//

import Foundation
import UserNotifications

public enum PermissionType {
    #if PERMISSION_BLUETOOTH
    case bluetooth
    #endif
    #if PERMISSION_CAMERA
    case camera
    #endif
    #if PERMISSION_CONTACTS
    case contacts
    #endif
    #if PERMISSION_EVENTS
    case events
    #endif
    #if PERMISSION_MOTION
    case motion
    #endif
    #if PERMISSION_MICROPHONE
    case microphone
    #endif
    #if PERMISSION_NOTIFICATIONS
    case notifications(options: UNAuthorizationOptions)
    #endif
    #if PERMISSION_PHOTO_LIBRARY
    case photoLibrary
    #endif
    #if PERMISSION_REMINDERS
    case reminders
    #endif
    #if PERMISSION_LOCATION
    case locationAlways
    case locationWhenInUse
    #endif
    #if PERMISSION_MEDIA_LIBRARY
    case mediaLibrary
    #endif
    #if PERMISSION_SPEECH_RECOGNIZER
    case speechRecognizer
    #endif
    #if PERMISSION_SIRI
    case siri
    #endif

    var permission: Permission.Type {
        switch self {
        #if PERMISSION_BLUETOOTH
        case .bluetooth: return Bluetooth.self
        #endif
        #if PERMISSION_CAMERA
        case .camera: return Camera.self
        #endif
        #if PERMISSION_CONTACTS
        case .contacts: return Contacts.self
        #endif
        #if PERMISSION_EVENTS
        case .events: return Events.self
        #endif
        #if PERMISSION_MOTION
        case .motion: return Motion.self
        #endif
        #if PERMISSION_MICROPHONE
        case .microphone: return Microphone.self
        #endif
        #if PERMISSION_NOTIFICATIONS
        case .notifications(let options): Notifications.options = options; return Notifications.self
        #endif
        #if PERMISSION_PHOTO_LIBRARY
        case .photoLibrary: return PhotoLibrary.self
        #endif
        #if PERMISSION_REMINDERS
        case .reminders: return Reminders.self
        #endif
        #if PERMISSION_LOCATION
        case .locationAlways: return LocationAlways.self
        case .locationWhenInUse: return LocationWhenInUse.self
        #endif
        #if PERMISSION_MEDIA_LIBRARY
        case .mediaLibrary: return MediaLibrary.self
        #endif
        #if PERMISSION_SPEECH_RECOGNIZER
        case .speechRecognizer: return SpeechRecognition.self
        #endif
        #if PERMISSION_SIRI
        case .siri: return Siri.self
        #endif
        }
    }
}
