// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let kamerVanKoopHandel = "Kamer van Koophandel"
    static let kvkModels = "Kamer van Koophandel Models"
    static let kvkShared = "Kamer van Koophandel Shared"
    
    static let basisprofiel = "Basisprofielen"
    static let naamgeving = "Naamgevingen"
    static let vestigingsprofiel = "Vestigingsprofielen"
    static let zoekenV1 = "Zoeken V1"
    static let zoekenV2 = "Zoeken V2"
}

extension Target.Dependency {
    static var kamerVanKoopHandel: Self {.target(name: .kamerVanKoopHandel) }
    static var kvkModels: Self { .target(name: .kvkModels) }
    static var kvkShared: Self { .target(name: .kvkShared) }
    
    static var basisprofiel: Self { .target(name: .basisprofiel) }
    static var naamgeving: Self { .target(name: .naamgeving) }
    static var vestigingsprofiel: Self { .target(name: .vestigingsprofiel) }
    static var zoekenV1: Self { .target(name: .zoekenV1) }
    static var zoekenV2: Self { .target(name: .zoekenV2) }
}

extension Target.Dependency {
    static var coenttbWeb: Self { .product(name: "Coenttb Web", package: "coenttb-web") }
    static var authentication: Self { .product(name: "Authentication", package: "swift-authentication") }
    static var dependenciesMacros: Self { .product(name: "DependenciesMacros", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
}

let package = Package(
    name: "swift-kamer-van-koophandel",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: .kamerVanKoopHandel,
            targets: [
                .kamerVanKoopHandel,
                .zoekenV2,
                .zoekenV1,
                .basisprofiel,
                .vestigingsprofiel,
                .naamgeving,
            ]
        ),
        .library(name: .zoekenV2, targets: [.zoekenV2]),
        .library(name: .zoekenV1, targets: [.zoekenV1]),
        .library(name: .basisprofiel, targets: [.basisprofiel]),
        .library(name: .vestigingsprofiel, targets: [.vestigingsprofiel]),
        .library(name: .naamgeving, targets: [.naamgeving]),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/coenttb-web.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-authentication.git", branch: "main"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.1.5"),
    ],
    targets: [
        .target(
            name: .kamerVanKoopHandel,
            dependencies: [
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
                .dependenciesMacros,
                .zoekenV2,
                .zoekenV1,
                .basisprofiel,
                .vestigingsprofiel,
                .naamgeving,
            ]
        ),
        .target(
            name: .kvkModels,
            dependencies: [
                .coenttbWeb,
                .kvkShared,
            ]
        ),
        .target(
            name: .kvkShared,
            dependencies: [
                .coenttbWeb,
                .dependenciesTestSupport,
                .authentication,
            ]
        ),
        .target(
            name: .basisprofiel,
            dependencies: [
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
                .dependenciesMacros,
            ]
        ),
        .testTarget(
            name: .basisprofiel.tests,
            dependencies: [
                .basisprofiel,
                .dependenciesTestSupport,
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
            ]
        ),
        .target(
            name: .naamgeving,
            dependencies: [
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
                .dependenciesMacros,
            ]
        ),
        .testTarget(
            name: .naamgeving.tests,
            dependencies: [
                .naamgeving,
                .dependenciesTestSupport,
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
            ]
        ),
        .target(
            name: .vestigingsprofiel,
            dependencies: [
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
                .dependenciesMacros,
            ]
        ),
        .testTarget(
            name: .vestigingsprofiel.tests,
            dependencies: [
                .vestigingsprofiel,
                .dependenciesTestSupport,
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
            ]
        ),
        .target(
            name: .zoekenV1,
            dependencies: [
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
                .dependenciesMacros,
            ]
        ),
        .testTarget(
            name: .zoekenV1.tests,
            dependencies: [
                .zoekenV1,
                .dependenciesTestSupport,
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
            ]
        ),
        .target(
            name: .zoekenV2,
            dependencies: [
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
                .dependenciesMacros,
            ]
        ),
        .testTarget(
            name: .zoekenV2.tests,
            dependencies: [
                .zoekenV2,
                .dependenciesTestSupport,
                .coenttbWeb,
                .kvkShared,
                .kvkModels,
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self {
        "\(self) Tests"
    }
}
