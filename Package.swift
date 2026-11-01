// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilStore",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilTheme", targets: ["AnvilTheme"]),
        .library(name: "AnvilUI", targets: ["AnvilUI"]),
        .library(name: "AnvilSources", targets: ["AnvilSources"]),
        .library(name: "AnvilShell", targets: ["AnvilShell"]),
        .library(name: "AnvilSetup", targets: ["AnvilSetup"]),
        .library(name: "AnvilAccounts", targets: ["AnvilAccounts"]),
        .library(name: "AnvilInstall", targets: ["AnvilInstall"]),
        .library(name: "AnvilRefresh", targets: ["AnvilRefresh"]),
        .library(name: "AnvilPatcher", targets: ["AnvilPatcher"]),
        .library(name: "AnvilCutaway", targets: ["AnvilCutaway"]),
        .library(name: "AnvilJIT", targets: ["AnvilJIT"]),
        .library(name: "AnvilDebug", targets: ["AnvilDebug"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2"),
    ],
    targets: [
        .target(
            name: "AnvilTheme",
            dependencies: [],
            path: "Packages/AnvilTheme/Sources"
        ),
        .testTarget(
            name: "AnvilThemeTests",
            dependencies: ["AnvilTheme"],
            path: "Packages/AnvilTheme/Tests"
        ),

        .target(
            name: "AnvilUI",
            dependencies: ["AnvilTheme"],
            path: "Packages/AnvilUI/Sources"
        ),
        .testTarget(
            name: "AnvilUITests",
            dependencies: ["AnvilUI"],
            path: "Packages/AnvilUI/Tests"
        ),

        .target(
            name: "AnvilSources",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "Packages/AnvilSources/Sources"
        ),
        .testTarget(
            name: "AnvilSourcesTests",
            dependencies: ["AnvilSources"],
            path: "Packages/AnvilSources/Tests"
        ),

        .target(
            name: "AnvilShell",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilSources",
                "AnvilSetup"
            ],
            path: "Packages/AnvilShell/Sources"
        ),
        .testTarget(
            name: "AnvilShellTests",
            dependencies: ["AnvilShell"],
            path: "Packages/AnvilShell/Tests"
        ),

        .target(
            name: "AnvilSetup",
            dependencies: [
                "AnvilTheme",
                "AnvilUI"
            ],
            path: "Packages/AnvilSetup/Sources"
        ),
        .testTarget(
            name: "AnvilSetupTests",
            dependencies: ["AnvilSetup"],
            path: "Packages/AnvilSetup/Tests"
        ),

        .target(
            name: "AnvilAccounts",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilSources",
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "Packages/AnvilAccounts/Sources"
        ),
        .testTarget(
            name: "AnvilAccountsTests",
            dependencies: ["AnvilAccounts"],
            path: "Packages/AnvilAccounts/Tests"
        ),

        .target(
            name: "AnvilInstall",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilAccounts",
                "AnvilSources",
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "Packages/AnvilInstall/Sources"
        ),
        .testTarget(
            name: "AnvilInstallTests",
            dependencies: ["AnvilInstall"],
            path: "Packages/AnvilInstall/Tests"
        ),

        .target(
            name: "AnvilRefresh",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilAccounts",
                "AnvilInstall",
                "AnvilSources"
            ],
            path: "Packages/AnvilRefresh/Sources"
        ),
        .testTarget(
            name: "AnvilRefreshTests",
            dependencies: ["AnvilRefresh"],
            path: "Packages/AnvilRefresh/Tests"
        ),

        .target(
            name: "AnvilPatcher",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilAccounts",
                "AnvilInstall"
            ],
            path: "Packages/AnvilPatcher/Sources"
        ),
        .testTarget(
            name: "AnvilPatcherTests",
            dependencies: ["AnvilPatcher"],
            path: "Packages/AnvilPatcher/Tests"
        ),

        .target(
            name: "AnvilCutaway",
            dependencies: [
                "AnvilTheme",
                "AnvilUI"
            ],
            path: "Packages/AnvilCutaway/Sources"
        ),
        .testTarget(
            name: "AnvilCutawayTests",
            dependencies: ["AnvilCutaway"],
            path: "Packages/AnvilCutaway/Tests"
        ),

        .target(
            name: "AnvilJIT",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilAccounts"
            ],
            path: "Packages/AnvilJIT/Sources"
        ),
        .testTarget(
            name: "AnvilJITTests",
            dependencies: ["AnvilJIT"],
            path: "Packages/AnvilJIT/Tests"
        ),

        .target(
            name: "AnvilDebug",
            dependencies: [
                "AnvilTheme",
                "AnvilUI"
            ],
            path: "Packages/AnvilDebug/Sources"
        ),
        .testTarget(
            name: "AnvilDebugTests",
            dependencies: ["AnvilDebug"],
            path: "Packages/AnvilDebug/Tests"
        ),
    ]
)