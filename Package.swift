// swift-tools-version:4.0
import PackageDescription


#if os(macOS)
	let CMeCabURL = "https://github.com/novi/CMeCab-OSX.git"
#else
	let CMeCabURL = "https://github.com/novi/CMeCab.git"
#endif

let package = Package(
    name: "MeCab",
    products: [
        .library(name: "MeCab", targets: ["MeCab"])
    ],
    dependencies: [
        .package(url: CMeCabURL, from: "1.0.0"),
    ],
    targets: [
        .target(name: "MeCab"),
        .testTarget(name: "MeCabTests", dependencies: ["MeCab"])
    ]
)
