// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "mecab-swift",
    products: [
        .library(name: "MeCab", targets: ["MeCab"])
    ],
    targets: [
        .systemLibrary(
            name: "CMeCab",
            path: "Sources/cmecab",
            pkgConfig: "cmecab",
            providers: [
                .brew(["mecab", "mecab-ipadic"]),
                .apt(["libmecab-dev", "mecab-ipadic-utf8"])
            ]
        ),
        .target(name: "MeCab", dependencies: ["CMeCab"]),
        .testTarget(name: "MeCabTests", dependencies: ["MeCab"])
    ]
)
