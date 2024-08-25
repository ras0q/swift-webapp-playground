// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird", from: "2.0.0-rc.4")
    ],
    targets: [
        .executableTarget(name: "App", dependencies: [
            .product(name: "Hummingbird", package: "hummingbird")
        ])
    ]
)
