// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PermissionAccess",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "PermissionAccess",
            targets: ["PermissionAccess"]),
    ],
    targets: [
        .target(
            name: "PermissionAccess",
            path: "PermissionAccess"),
    ]
)
