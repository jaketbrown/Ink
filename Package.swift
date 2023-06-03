// swift-tools-version:5.2

/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "Ink",
    products: [
        .library(name: "Ink", targets: ["Ink"]),
        .executable(name: "ink-cli", targets: ["InkCLI"]),
        .executable(name: "fuzz-ink", targets: ["InkFuzz"])
    ],
    targets: [
        .target(name: "Ink"),
        .target(name: "InkCLI", dependencies: ["Ink"]),
        .target(name: "InkFuzz", dependencies: ["Ink"],
                path: "mayhem",
                sources: ["main.swift", "FuzzedDataProvider.swift"],
                swiftSettings: [
                    .unsafeFlags(["-sanitize=fuzzer,address"]),
                    .unsafeFlags(["-parse-as-library"])],
                linkerSettings: [
                    .unsafeFlags(["-sanitize=fuzzer,address"])
                ]
        ),
        .testTarget(name: "InkTests", dependencies: ["Ink"])
    ]
)
