import Foundation
import Dependencies
import DependenciesMacros
import Testing
import EnvironmentVariables
import DependenciesTestSupport
import IssueReporting
import Kamer_van_Koophandel_Shared
@testable import Naamgevingen
@testable import Kamer_van_Koophandel_Models
import Coenttb_Authentication

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Naamgevingen.AuthenticatedClient: @retroactive TestDependencyKey {
    public static let testValue: Self = {
        @Dependency(TestStrategy.self) var testStrategy
        
        return switch testStrategy {
        case .local:
            try! Naamgevingen.AuthenticatedClient.test { Naamgevingen.Client.testValue }
        case .liveTest:
            try! Naamgevingen.AuthenticatedClient.test { Naamgevingen.Client.live(makeRequest: $0) }
        case .live:
            try! Naamgevingen.AuthenticatedClient.test { Naamgevingen.Client.live(makeRequest: $0) }
        }
    }()
}
