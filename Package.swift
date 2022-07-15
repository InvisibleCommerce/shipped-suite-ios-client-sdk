// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShippedSuite",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "ShippedSuite",
            targets: ["ShippedSuite"])
    ],
    targets: [
        .target(
            name: "ShippedSuite",
            path: "ShippedSuite",
            publicHeadersPath: "")
    ]
)
