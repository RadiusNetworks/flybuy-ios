// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FlyBuy",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FlyBuyPickup",
            targets: ["FlyBuy", "FlyBuyPickup"]
        ),
        .library(
            name: "FlyBuyNotify",
            targets: ["FlyBuy", "FlyBuyNotify"]
        ),
        .library(
            name: "FlyBuyPresence",
            targets: ["FlyBuy", "FlyBuyPresence"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "FlyBuy",
            path: "FlyBuy.xcframework"
        ),
        .binaryTarget(
            name: "FlyBuyPickup",
            path: "FlyBuyPickup.xcframework"
        ),
        .binaryTarget(
            name: "FlyBuyNotify",
            path: "FlyBuyNotify.xcframework"
        ),
        .binaryTarget(
            name: "FlyBuyPresence",
            path: "FlyBuyPresence.xcframework"
        )
    ]
)
