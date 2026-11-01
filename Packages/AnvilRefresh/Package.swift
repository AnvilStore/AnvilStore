// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilRefresh",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilRefresh", targets: ["AnvilRefresh"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
        .package(path: "../AnvilAccounts"),
        .package(path: "../AnvilInstall"),
        .package(path: "../AnvilSources"),
    ],
    targets: [
        .target(
            name: "AnvilRefresh",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilAccounts",
                "AnvilInstall",
                "AnvilSources"
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilRefreshTests",
            dependencies: ["AnvilRefresh"],
            path: "Tests"
        )
    ]
)