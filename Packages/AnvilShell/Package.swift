// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilShell",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilShell", targets: ["AnvilShell"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
        .package(path: "../AnvilSources"),
        .package(path: "../AnvilSetup"),
        .package(path: "../AnvilAccounts"),
        .package(path: "../AnvilInstall"),
        .package(path: "../AnvilRefresh"),
        .package(path: "../AnvilPatcher"),
        .package(path: "../AnvilCutaway"),
        .package(path: "../AnvilJIT"),
        .package(path: "../AnvilDebug"),
    ],
    targets: [
        .target(
            name: "AnvilShell",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilSources",
                "AnvilSetup",
                "AnvilAccounts",
                "AnvilInstall",
                "AnvilRefresh",
                "AnvilPatcher",
                "AnvilCutaway",
                "AnvilJIT",
                "AnvilDebug",
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilShellTests",
            dependencies: ["AnvilShell"],
            path: "Tests"
        )
    ]
)