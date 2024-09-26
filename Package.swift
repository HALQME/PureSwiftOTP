// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PureSwiftOTP",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6),
    ],
    products: [
        .library(name: "PureSwiftOTP", targets: ["PureSwiftOTP"])
    ],
    dependencies: [
        .package(url: "https://github.com/norio-nomura/Base32", .upToNextMajor(from: "0.9.0")),
        .package(url: "https://github.com/HALQME/DataEnhance", branch: "main"),
    ],
    targets: [
        .target(name: "PureSwiftOTP", dependencies: ["Base32","DataEnhance"]),
        .testTarget(name: "PureSwiftOTPTests", dependencies: ["PureSwiftOTP"]),
    ]
)
