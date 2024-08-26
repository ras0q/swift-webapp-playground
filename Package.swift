// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird", from: "2.0.0-rc.4"),
        .package(url: "https://github.com/TokamakUI/Tokamak", from: "0.11.0"),
        .package(url: "https://github.com/vapor/mysql-kit.git", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(name: "App", dependencies: [
            .product(name: "Hummingbird", package: "hummingbird"),
            .product(name: "MySQLKit", package: "mysql-kit")
        ]),
        .executableTarget(name: "Client", dependencies: [
            .product(name: "TokamakShim", package: "Tokamak")
        ])
    ]
)
