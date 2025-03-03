// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShoppeStore",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "ShoppeStore",
            targets: ["ShoppeStore"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ShapovalovIlya/SwiftFP.git", branch: "main")
    ],
    targets: [
        .target(
            name: "ShoppeStore",
            dependencies: [
                .product(name: "SwiftFP", package: "SwiftFP")
            ],
            swiftSettings: [
//                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "ShoppeNetworkingTests",
            dependencies: ["ShoppeStore"]
        ),
    ]
)
