// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "adventofcode23",
    platforms: [.macOS(.v12)],
    targets: [
        .executableTarget(
            name: "adventofcode23",
            resources: [.copy("Input")]
        )
    ]
)
