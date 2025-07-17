// swift-tools-version: 5.8

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "NineteenTrillionSolution",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "NineteenTrillionSolution",
            targets: ["AppModule"],
            bundleIdentifier: "org.tiation.NineteenTrillionSolution",
            teamIdentifier: "",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .money),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)
