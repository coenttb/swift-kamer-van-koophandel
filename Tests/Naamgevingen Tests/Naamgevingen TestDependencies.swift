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

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension AuthenticatedClient: @retroactive TestDependencyKey {
    public static let testValue: Self = {
        @Dependency(TestStrategy.self) var testStrategy
        
        return switch testStrategy {
        case .local:
            try! AuthenticatedClient.test { Client.testValue }
        case .liveTest:
            try! AuthenticatedClient.test { Client.live(makeRequest: $0) }
        case .live:
            try! AuthenticatedClient.test { Client.live(makeRequest: $0) }
        }
    }()
}
