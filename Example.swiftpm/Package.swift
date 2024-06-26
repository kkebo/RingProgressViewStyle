// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Example",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "Example",
            targets: ["AppModule"],
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .beachball),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kkebo/RingProgressViewStyle", "0.2.0"..<"0.3.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                "RingProgressViewStyle"
            ],
            path: "."
        )
    ]
)
