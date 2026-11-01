// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilUI", targets: ["AnvilUI"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme")
    ],
    targets: [
        .target(
            name: "AnvilUI",
            dependencies: ["AnvilTheme"],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilUITests",
            dependencies: ["AnvilUI"],
            path: "Tests"
        )
    ]
)