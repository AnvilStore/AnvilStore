// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilJIT",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilJIT", targets: ["AnvilJIT"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
        .package(path: "../AnvilAccounts"),
    ],
    targets: [
        .target(
            name: "AnvilJIT",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilAccounts"
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilJITTests",
            dependencies: ["AnvilJIT"],
            path: "Tests"
        )
    ]
)