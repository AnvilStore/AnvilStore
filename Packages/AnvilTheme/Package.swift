// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilTheme",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilTheme", targets: ["AnvilTheme"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AnvilTheme",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilThemeTests",
            dependencies: ["AnvilTheme"],
            path: "Tests"
        )
    ]
)