// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NineteenTrillionSolution",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "NineteenTrillionSolution",
            targets: ["NineteenTrillionSolution"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NineteenTrillionSolution",
            dependencies: [],
            path: "Sources"
        ),
    ]
)
