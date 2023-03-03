// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "WindowsDetector",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .library(
            name: "WindowsDetector",
            targets: ["WindowsDetector"])
    ],
    dependencies: [],
    targets: [
        .target(name: "WindowsDetector", dependencies: []),
        .testTarget(name: "WindowsDetectorTests", dependencies: ["WindowsDetector"])
    ]
)
