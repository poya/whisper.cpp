// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "whisper_cpp",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(
            name: "whisper_cpp",
            targets: ["whisper_cpp"]),
        .library(
            name: "coreml_whisper_cpp",
            targets: ["coreml_whisper_cpp"]),
    ],
    targets: [
        .target(
            name: "whisper_cpp",
            resources: [
                .process("ggml-metal.metal")
            ],
            cSettings: [
                .headerSearchPath("../.."),
                .unsafeFlags(["-O3", "-fno-objc-arc"]),
                .define("GGML_USE_ACCELERATE"),
                .define("GGML_USE_METAL"),
                .define("GGML_METAL_NDEBUG", .when(configuration: .release)),
            ]
        ),
        .target(
            name: "coreml_whisper_cpp",
            cSettings: [
                .headerSearchPath("../.."),
                .unsafeFlags(["-O3"]),
                .define("GGML_USE_ACCELERATE"),
                .define("WHISPER_USE_COREML"),
                .define("WHISPER_COREML_ALLOW_FALLBACK"),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx11
)
