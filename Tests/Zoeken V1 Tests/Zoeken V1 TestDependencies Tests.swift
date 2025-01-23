import Foundation
import Dependencies
import DependenciesMacros
import Testing
import EnvironmentVariables
import DependenciesTestSupport
import IssueReporting
import Kamer_van_Koophandel_Shared
@testable import Zoeken_V1
@testable import Kamer_van_Koophandel_Models

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension AuthenticatedClientV1: @retroactive TestDependencyKey {
    public static let testValue: Self = {
        @Dependency(TestStrategy.self) var testStrategy
        
        return switch testStrategy {
        case .local:
            try! AuthenticatedClientV1.test { ClientV1.testValue }
            
        case .liveTest:
            try! AuthenticatedClientV1.test { ClientV1.live(makeRequest: $0) }
            
        case .live:
            try! AuthenticatedClientV1.test { ClientV1.live(makeRequest: $0) }
        }
    }()
}
