// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Generator",
    dependencies: [
        .Package(url: "https://github.com/dreymonde/CocoaMapper.git", majorVersion: 0),
        .Package(url: "https://github.com/dreymonde/Shallows.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/johnsundell/files.git", majorVersion: 1),
        .Package(url: "https://github.com/johnsundell/shellout.git", majorVersion: 1),
        .Package(url: "https://github.com/naoty/Timepiece.git", majorVersion: 1),
    ]
)
