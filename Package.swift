// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rocket",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Rocket",
            targets: ["Rocket"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.9.0"),
        .package(url: "https://github.com/mxcl/PromiseKit.git", from: "6.11.0"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Rocket",
            dependencies: [
                "Alamofire",
                "PromiseKit",
                "SwiftyJSON",
            ]
        ),
        .testTarget(
            name: "RocketTests",
            dependencies: ["Rocket"]
        ),
    ]
)
