import PackageDescription

#if os(OSX)
	let CMeCabURL = "https://github.com/novi/CMeCab-OSX.git"
#else
	let CMeCabURL = "https://github.com/novi/CMeCab.git"
#endif

let package = Package(
    name: "MeCab",
    dependencies: [
        .Package(url: CMeCabURL, majorVersion: 1)
    ],
    exclude: ["OSX Projects"]
)