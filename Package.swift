// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "temporal-sandbox",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .visionOS(.v2)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-temporal-sdk.git", from: "0.3.0"),
        .package(url: "https://github.com/Eisenhuth/Ospuze.git", branch: "master"),         //package to get leaderboard data for The Finals
        .package(url: "https://github.com/Eisenhuth/xivapi-swift.git", branch: "master"),   //package to get FFXIV game data from xivapi.com
        .package(url: "https://github.com/Eisenhuth/universalis-swift", branch: "master")   //package to get FFXIV market data from universalis.com
    ],
    targets: [
        .testTarget(
            name: "temporal-sandboxTests",
            dependencies: ["temporal-sandbox"]
        ),
        .executableTarget(
            name: "temporal-sandbox",
            dependencies: [
                .product(name: "Temporal", package: "swift-temporal-sdk"),
                .product(name: "Ospuze", package: "Ospuze"),
                .product(name: "xivapi-swift", package: "xivapi-swift"),
                .product(name: "universalis-swift", package: "universalis-swift")
            ],
        ),
    ]
)
