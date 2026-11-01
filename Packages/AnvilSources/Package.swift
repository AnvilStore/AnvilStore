// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilSources",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilSources", targets: ["AnvilSources"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.0"),
    ],
    targets: [
        .target(
            name: "AnvilSources",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilSourcesTests",
            dependencies: ["AnvilSources"],
            path: "Tests"
        )
    ]
)