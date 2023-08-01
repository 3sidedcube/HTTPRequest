// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTTPRequest",
    platforms: [
        .macOS(.v11),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "HTTPRequest",
            targets: ["HTTPRequest"]
        ),
        .executable(
            name: "StravaAPI",
            targets: ["StravaAPI"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.6.0")
        )
    ],
    targets: [
        .target(
            name: "HTTPRequest",
            dependencies: ["Alamofire"],
            path: "Sources"
        ),
        .executableTarget(
            name: "StravaAPI",
            dependencies: ["HTTPRequest"],
            path: "StravaAPI"
        ),
        .testTarget(
            name: "HTTPRequestTests",
            dependencies: ["HTTPRequest"]
        )
    ]
)
