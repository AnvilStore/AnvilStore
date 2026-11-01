// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilInstall",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilInstall", targets: ["AnvilInstall"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
        .package(path: "../AnvilAccounts"),
        .package(path: "../AnvilSources"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2")
    ],
    targets: [
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
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilInstallTests",
            dependencies: ["AnvilInstall"],
            path: "Tests"
        )
    ]
)