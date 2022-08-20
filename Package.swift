// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Showcase",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "RingProgressViewStyle",
            targets: ["RingProgressViewStyle"]
        )
    ],
    targets: [
        .target(
            name: "RingProgressViewStyle"
        ),
    ]
)
