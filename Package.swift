// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Ipecac",
    products: [
        .library(
            name: "Ipecac",
            targets: ["Ipecac"]),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "Ipecac",
            dependencies: []),
        .testTarget(
            name: "IpecacTests",
            dependencies: ["Ipecac"]),
    ]
)
