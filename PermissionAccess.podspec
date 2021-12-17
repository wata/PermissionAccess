Pod::Spec.new do |s|
  s.name          = "PermissionAccess"
  s.version       = "0.1.0"
  s.summary       = "A unified API to ask for permissions on iOS."
  s.homepage      = "https://github.com/wata/PermissionAccess"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = "Wataru Nagasawa"
  s.source        = { :git => "#{s.homepage}.git", :tag => s.version.to_s }
  s.platform      = :ios, '11.0'
  s.swift_version = '5.0'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = "PermissionAccess/**/*.swift"
  end

  s.subspec 'Bluetooth' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_BLUETOOTH" }
  end

  s.subspec 'Camera' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_CAMERA" }
  end

  s.subspec 'Contacts' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_CONTACTS" }
  end

  s.subspec 'Events' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_EVENTS" }
  end

  s.subspec 'Location' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_LOCATION" }
  end

  s.subspec 'Microphone' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_MICROPHONE" }
  end

  s.subspec 'Motion' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_MOTION" }
  end

  s.subspec 'Notifications' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_NOTIFICATIONS" }
  end

  s.subspec 'PhotoLibrary' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_PHOTO_LIBRARY" }
  end

  s.subspec 'Reminders' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_REMINDERS" }
  end

  s.subspec 'Siri' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_SIRI" }
  end

  s.subspec 'SpeechRecognition' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_SPEECH_RECOGNITION" }
  end

  s.subspec 'MediaLibrary' do |ss|
    ss.dependency 'PermissionAccess/Core'
    ss.pod_target_xcconfig = { "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "PERMISSION_MEDIA_LIBRARY" }
  end
end