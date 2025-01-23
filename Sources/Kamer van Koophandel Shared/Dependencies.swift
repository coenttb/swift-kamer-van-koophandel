//
//  File.swift
//  swift-kamer-van-koophandel
//
//  Created by Coen ten Thije Boonkkamp on 23/01/2025.
//

import Foundation
import Dependencies

extension DependencyValues {
    public struct KamerVanKoophandel: Equatable, Sendable {
        public let baseUrl: URL
    }
}

extension DependencyValues.KamerVanKoophandel: DependencyKey {
    public static let testValue: DependencyValues.KamerVanKoophandel = .init(baseUrl: URL(string: "https://api.kvk.nl")!)
    public static let liveValue: DependencyValues.KamerVanKoophandel = .init(baseUrl: URL(string: "https://api.kvk.nl")!)
}

extension DependencyValues {
    public var kamerVanKoophandel: DependencyValues.KamerVanKoophandel {
        get { self[DependencyValues.KamerVanKoophandel.self] }
        set { self[DependencyValues.KamerVanKoophandel.self] = newValue }
    }
}
