// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherConnect",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WeatherConnect",
            targets: ["WeatherConnect"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WeatherConnect",
            path: "Source",
            resources: [
                .process("Resources/Satoshi-Bold.otf"),
                .process("Resources/Satoshi-Medium.otf"),
                
                // Include the asset catalog
                .process("Resources/WeatherConnectSDK.xcassets")
            ]),
        .testTarget(
            name: "WeatherConnectTests",
            dependencies: ["WeatherConnect"]
        ),
    ]
)
