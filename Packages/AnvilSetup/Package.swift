// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilSetup",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilSetup", targets: ["AnvilSetup"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
    ],
    targets: [
        .target(
            name: "AnvilSetup",
            dependencies: [
                "AnvilTheme",
                "AnvilUI"
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilSetupTests",
            dependencies: ["AnvilSetup"],
            path: "Tests"
        )
    ]
)