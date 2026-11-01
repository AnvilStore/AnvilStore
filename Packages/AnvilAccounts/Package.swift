// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AnvilAccounts",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "AnvilAccounts", targets: ["AnvilAccounts"])
    ],
    dependencies: [
        .package(path: "../AnvilTheme"),
        .package(path: "../AnvilUI"),
        .package(path: "../AnvilSources"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2")
    ],
    targets: [
        .target(
            name: "AnvilAccounts",
            dependencies: [
                "AnvilTheme",
                "AnvilUI",
                "AnvilSources",
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AnvilAccountsTests",
            dependencies: ["AnvilAccounts"],
            path: "Tests"
        )
    ]
)