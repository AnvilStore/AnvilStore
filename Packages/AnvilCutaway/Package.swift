// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilCutaway",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilCutaway", targets: ["AnvilCutaway"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
    ],
    targets: [
        .target(
            name: "AnvilCutaway",
            dependencies: [
                "AnvilTheme",
                "AnvilUI"
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilCutawayTests",
            dependencies: ["AnvilCutaway"],
            path: "Tests"
        )
    ]
)