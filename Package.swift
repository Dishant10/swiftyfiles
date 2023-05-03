// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftyfiles",
    dependencies:[
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
    .package(url: "https://github.com/RNCryptor/RNCryptor.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "swiftyfiles",
            dependencies: [
                .product(name: "ArgumentParser",package: "swift-argument-parser"),
                .product(name: "RNCryptor",package: "RNCryptor"),
                ],
            path: "Sources"),
    ]
)
