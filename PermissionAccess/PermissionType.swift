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
    case bluetooth
    case camera
    case contacts
    case events
    case motion
    case microphone
    case notifications(options: UNAuthorizationOptions)
    case photoLibrary
    case reminders
    case locationAlways
    case locationWhenInUse
    case mediaLibrary
    case speechRecognizer
    case siri

    var permission: Permission.Type {
        switch self {
        case .bluetooth:
            return Bluetooth.self
        case .camera:
            return Camera.self
        case .contacts:
            return Contacts.self
        case .events:
            return Events.self
        case .motion:
            return Motion.self
        case .microphone:
            return Microphone.self
        case .notifications(let options):
            Notifications.options = options
            return Notifications.self
        case .photoLibrary:
            return PhotoLibrary.self
        case .reminders:
            return Reminders.self
        case .locationAlways:
            return LocationAlways.self
        case .locationWhenInUse:
            return LocationWhenInUse.self
        case .mediaLibrary:
            return MediaLibrary.self
        case .speechRecognizer:
            return SpeechRecognition.self
        case .siri:
            return Siri.self
        }
    }
}
