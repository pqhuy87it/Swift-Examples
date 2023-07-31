// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Async-Await-Sample",
    platforms: [.macOS(.v12)],
    dependencies: [],
    targets: [
        .executableTarget(name: "Async-Await-Sample", dependencies: [])
    ]
)
