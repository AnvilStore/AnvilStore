// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilDebug",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilDebug", targets: ["AnvilDebug"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
    ],
    targets: [
        .target(
            name: "AnvilDebug",
            dependencies: [
                "AnvilTheme",
                "AnvilUI"
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilDebugTests",
            dependencies: ["AnvilDebug"],
            path: "Tests"
        )
    ]
)