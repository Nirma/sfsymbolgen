// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sfsymbolgen",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "sfsymbolgen", targets: ["sfsymbolgen"])
    ],
    dependencies: [
        .package(url: "https://github.com/Nirma/SFSymbolParserGen.git", from: .init(0, 1, 0)),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .executableTarget(name: "sfsymbolgen",
                          dependencies: [
                            .product(name: "SFSymbolParserGen", package: "SFSymbolParserGen"),
                            .product(name: "ArgumentParser", package: "swift-argument-parser"),]),
    ]
)
