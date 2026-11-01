// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilPatcher",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilPatcher", targets: ["AnvilPatcher"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
        .package(path: "../AnvilAccounts"),
        .package(path: "../AnvilInstall"),
    ],
    targets: [
        .target(
            name: "AnvilPatcher",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilAccounts",
                "AnvilInstall"
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilPatcherTests",
            dependencies: ["AnvilPatcher"],
            path: "Tests"
        )
    ]
)