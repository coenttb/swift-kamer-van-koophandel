import Foundation
import Dependencies
import DependenciesMacros
import Kamer_van_Koophandel_Models
import Kamer_van_Koophandel_Shared

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Client: TestDependencyKey {
    public static let testValue: Self = {
        return Self.init(
            basisprofiel: .testValue,
            naamgeving: .testValue,
            vestigingsprofiel: .testValue,
            zoeken: .init(v1: .testValue, v2: .testValue)
        )
    }()
}

extension AuthenticatedClient: @retroactive TestDependencyKey {
    public static let testValue: AuthenticatedClient = {
        try! AuthenticatedClient.test { Client.testValue }
    }()
}
